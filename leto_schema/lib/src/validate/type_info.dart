// ignore_for_file: unnecessary_this, public_member_api_docs, prefer_is_empty

import 'package:gql/ast.dart';
import 'package:leto_schema/introspection.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/utilities/build_schema.dart';
import 'package:leto_schema/src/utilities/predicates.dart';
import 'package:leto_schema/src/validate/typed_visitor.dart';

class TypeInfo {
  final GraphQLSchema _schema;
  final List<GraphQLType?> _typeStack = [];
  final List<GraphQLCompositeType?> _parentTypeStack = [];
  final List<GraphQLType?> _inputTypeStack = [];
  final List<GraphQLObjectField?> _fieldDefStack = [];
  final List<Object?> _defaultValueStack = [];
  GraphQLDirective? _directive;
  GraphQLFieldInput? _argument;
  GraphQLEnumValue? _enumValue;
  final GetFieldDefFn _getFieldDef;

  TypeInfo(
    this._schema,
    /**
     * Initial type may be provided in rare cases to facilitate traversals
     *  beginning somewhere other than documents.
     */
    // initialType?: Maybe<GraphQLType>,
    [
    this._getFieldDef = globalGetFieldDef,
  ]);
  // {
  // this._getFieldDef = getFieldDefFn ?? getFieldDef;
  // if (initialType) {
  //   if (isInputType(initialType)) {
  //     this._inputTypeStack.add(initialType);
  //   }
  //   if (isCompositeType(initialType)) {
  //     this._parentTypeStack.add(initialType);
  //   }
  //   if (isOutputType(initialType)) {
  //     this._typeStack.add(initialType);
  //   }
  // }
  // }

  GraphQLType? getType() {
    if (this._typeStack.length > 0) {
      return this._typeStack[this._typeStack.length - 1];
    }
  }

  GraphQLCompositeType? getParentType() {
    if (this._parentTypeStack.length > 0) {
      return this._parentTypeStack[this._parentTypeStack.length - 1];
    }
  }

  GraphQLType? getInputType() {
    if (this._inputTypeStack.length > 0) {
      return this._inputTypeStack[this._inputTypeStack.length - 1];
    }
  }

  GraphQLType? getParentInputType() {
    if (this._inputTypeStack.length > 1) {
      return this._inputTypeStack[this._inputTypeStack.length - 2];
    }
  }

  GraphQLObjectField? getFieldDef() {
    if (this._fieldDefStack.length > 0) {
      return this._fieldDefStack[this._fieldDefStack.length - 1];
    }
  }

  Object? getDefaultValue() {
    if (this._defaultValueStack.length > 0) {
      return this._defaultValueStack[this._defaultValueStack.length - 1];
    }
  }

  GraphQLDirective? getDirective() {
    return this._directive;
  }

  GraphQLFieldInput? getArgument() {
    return this._argument;
  }

  GraphQLEnumValue? getEnumValue() {
    return this._enumValue;
  }

  void enter(Node node) {
    final schema = this._schema;
    // Note: many of the types below are explicitly typed as "unknown" to drop
    // any assumptions of a valid schema to ensure runtime types are properly
    // checked before continuing since TypeInfo is used as part of validation
    // which occurs before guarantees of schema and document validity.
    if (node is SelectionSetNode) {
      final namedType = _call(getNamedType, this.getType());
      this._parentTypeStack.add(
            namedType is GraphQLCompositeType ? namedType : null,
          );
    } else if (node is FieldNode) {
      final parentType = this.getParentType();
      GraphQLObjectField? fieldDef;
      GraphQLType? fieldType;
      if (parentType != null) {
        fieldDef = this._getFieldDef(schema, parentType, node);
        if (fieldDef != null) {
          fieldType = fieldDef.type;
        }
      }
      this._fieldDefStack.add(fieldDef);
      this._typeStack.add(isOutputType(fieldType) ? fieldType : null);
    } else if (node is DirectiveNode) {
      this._directive = schema.getDirective(node.name.value);
    } else if (node is OperationDefinitionNode) {
      final rootType = schema.getRootType(node.type);
      this._typeStack.add(
            rootType is GraphQLObjectType && !rootType.isInterface
                ? rootType
                : null,
          );
    } else if (node is InlineFragmentNode || node is FragmentDefinitionNode) {
      final typeConditionAST = node is InlineFragmentNode
          ? node.typeCondition
          : (node as FragmentDefinitionNode).typeCondition;
      final outputType = typeConditionAST != null
          ? convertTypeOrNull(typeConditionAST.on, schema.typeMap)
          : _call(getNamedType, this.getType());
      this._typeStack.add(isOutputType(outputType) ? outputType : null);
    } else if (node is VariableDefinitionNode) {
      final inputType = convertTypeOrNull(node.type, schema.typeMap);
      this._inputTypeStack.add(
            isInputType(inputType) ? inputType : null,
          );
    } else if (node is ArgumentNode) {
      GraphQLFieldInput? argDef;
      GraphQLType? argType;
      final fieldOrDirectiveInputs =
          this.getDirective()?.inputs ?? this.getFieldDef()?.inputs;
      if (fieldOrDirectiveInputs != null) {
        final index = fieldOrDirectiveInputs.indexWhere(
          (arg) => arg.name == node.name.value,
        );
        argDef = index == -1 ? null : fieldOrDirectiveInputs[index];
        if (argDef != null) {
          argType = argDef.type;
        }
      }
      this._argument = argDef;
      this._defaultValueStack.add(argDef?.defaultValue);
      this._inputTypeStack.add(isInputType(argType) ? argType : null);
    } else if (node is ListValueNode) {
      final listType = this.getInputType()?.nullable();
      final itemType = listType is GraphQLListType ? listType.ofType : listType;
      // List positions never have a default value.
      this._defaultValueStack.add(null);
      this._inputTypeStack.add(isInputType(itemType) ? itemType : null);
    } else if (node is ObjectFieldNode) {
      final objectType = _call(getNamedType, this.getInputType());
      GraphQLType? inputFieldType;
      GraphQLFieldInput? inputField;
      if (objectType is GraphQLInputObjectType) {
        inputField = objectType.fieldByName(node.name.value);
        if (inputField != null) {
          inputFieldType = inputField.type;
        }
      }
      this._defaultValueStack.add(inputField?.defaultValue);
      this._inputTypeStack.add(
            isInputType(inputFieldType) ? inputFieldType : null,
          );
    } else if (node is EnumValueNode) {
      final enumType = _call(getNamedType, this.getInputType());
      GraphQLEnumValue? enumValue;
      if (enumType is GraphQLEnumType) {
        enumValue = enumType.getValue(node.name.value);
      }
      this._enumValue = enumValue;
    }
  }

  void leave(Node node) {
    if (node is SelectionSetNode) {
      this._parentTypeStack.removeLast();
    } else if (node is FieldNode) {
      this._fieldDefStack.removeLast();
      this._typeStack.removeLast();
    } else if (node is DirectiveNode) {
      this._directive = null;
    } else if (node is OperationDefinitionNode ||
        node is FragmentDefinitionNode ||
        node is InlineFragmentNode) {
      this._typeStack.removeLast();
    } else if (node is VariableDefinitionNode) {
      this._inputTypeStack.removeLast();
    } else if (node is ArgumentNode) {
      this._argument = null;
      this._defaultValueStack.removeLast();
      this._inputTypeStack.removeLast();
    } else if (node is ListValueNode || node is ObjectFieldNode) {
      this._defaultValueStack.removeLast();
      this._inputTypeStack.removeLast();
    } else if (node is EnumValueNode) {
      this._enumValue = null;
    }
  }
}

T? _call<T, P>(T Function(P) func, P? arg) => arg == null ? null : func(arg);

///
typedef GetFieldDefFn = GraphQLObjectField? Function(
  GraphQLSchema schema,
  GraphQLType parentType,
  FieldNode fieldNode,
);

/// Not exactly the same as the executor's definition of getFieldDef, in this
/// statically evaluated environment we do not always have an Object type,
/// and need to handle Interface and Union types.
GraphQLObjectField? globalGetFieldDef(
  GraphQLSchema schema,
  GraphQLType parentType,
  FieldNode fieldNode,
) {
  final name = fieldNode.name.value;
  if (name == schemaIntrospectionTypeField.name &&
      schema.queryType == parentType) {
    return schemaIntrospectionTypeField;
  } else if (name == typeIntrospectionTypeField.name &&
      schema.queryType == parentType) {
    return typeIntrospectionTypeField;
  } else if (name == typenameIntrospectionField.name &&
      isCompositeType(parentType)) {
    return typenameIntrospectionField;
  } else if (parentType is GraphQLObjectType) {
    return parentType.fieldByName(name);
  }
}

/**
 * Creates a new visitor instance which maintains a provided TypeInfo instance
 * along with visiting visitor.
 */
// WithTypeInfoVisitor visitWithTypeInfo(
//   TypeInfo typeInfo,
//   visitor: ASTVisitor,
// ) {
//   return {
//     enter(...args) {
//       final node = args[0];
//       typeInfo.enter(node);
//       final fn = getEnterLeaveForKind(visitor, node.kind).enter;
//       if (fn) {
//         final result = fn.apply(visitor, args);
//         if (result !== null) {
//           typeInfo.leave(node);
//           if (isNode(result)) {
//             typeInfo.enter(result);
//           }
//         }
//         return result;
//       }
//     },
//     leave(...args) {
//       final node = args[0];
//       final fn = getEnterLeaveForKind(visitor, node.kind).leave;
//       var result;
//       if (fn) {
//         result = fn.apply(visitor, args);
//       }
//       typeInfo.leave(node);
//       return result;
//     },
//   };
// }

///
class WithTypeInfoVisitor extends ParallelVisitor {
  final TypeInfo typeInfo;

  ///
  WithTypeInfoVisitor(
    this.typeInfo, {
    required List<Visitor> visitors,
    void Function(Object?)? onAccept,
  }) : super(
          visitors: visitors,
          onAccept: onAccept,
        );

  void _wrap<T extends Node>(T node, void Function(T) inner) {
    typeInfo.enter(node);
    inner(node);
    typeInfo.leave(node);
  }

  @override
  void visitSelectionSetNode(SelectionSetNode node) =>
      _wrap(node, super.visitSelectionSetNode);
  @override
  void visitFieldNode(FieldNode node) => _wrap(node, super.visitFieldNode);
  @override
  void visitDirectiveNode(DirectiveNode node) =>
      _wrap(node, super.visitDirectiveNode);
  @override
  void visitOperationDefinitionNode(OperationDefinitionNode node) =>
      _wrap(node, super.visitOperationDefinitionNode);
  @override
  void visitInlineFragmentNode(InlineFragmentNode node) =>
      _wrap(node, super.visitInlineFragmentNode);
  @override
  void visitFragmentDefinitionNode(FragmentDefinitionNode node) =>
      _wrap(node, super.visitFragmentDefinitionNode);
  @override
  void visitVariableDefinitionNode(VariableDefinitionNode node) =>
      _wrap(node, super.visitVariableDefinitionNode);
  @override
  void visitArgumentNode(ArgumentNode node) =>
      _wrap(node, super.visitArgumentNode);
  @override
  void visitListValueNode(ListValueNode node) =>
      _wrap(node, super.visitListValueNode);
  @override
  void visitObjectFieldNode(ObjectFieldNode node) =>
      _wrap(node, super.visitObjectFieldNode);
  @override
  void visitEnumValueNode(EnumValueNode node) =>
      _wrap(node, super.visitEnumValueNode);
}
