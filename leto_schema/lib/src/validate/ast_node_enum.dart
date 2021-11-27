// ignore_for_file: public_member_api_docs, constant_identifier_names, curly_braces_in_flow_control_structures

import 'package:gql/ast.dart';

enum Kind {
  Argument,
  BooleanValue,
  DefaultValue,
  DirectiveDefinition,
  Directive,
  Document,
  EnumTypeDefinition,
  EnumTypeExtension,
  EnumValueDefinition,
  EnumValue,
  FieldDefinition,
  Field,
  FloatValue,
  FragmentDefinition,
  FragmentSpread,
  InlineFragment,
  InputObjectTypeDefinition,
  InputObjectTypeExtension,
  InputValueDefinition,
  IntValue,
  InterfaceTypeDefinition,
  InterfaceTypeExtension,
  ListType,
  ListValue,
  Name,
  NamedType,
  NullValue,
  ObjectField,
  ObjectTypeDefinition,
  ObjectTypeExtension,
  ObjectValue,
  OperationDefinition,
  OperationTypeDefinition,
  ScalarTypeDefinition,
  ScalarTypeExtension,
  SchemaDefinition,
  SchemaExtension,
  SelectionSet,
  StringValue,
  TypeCondition,
  UnionTypeDefinition,
  UnionTypeExtension,
  VariableDefinition,
  Variable,
}

///
extension EnumExt on Node {
  Kind get kind {
    final v = this;
    if (v is ArgumentNode)
      return Kind.Argument;
    else if (v is BooleanValueNode)
      return Kind.BooleanValue;
    else if (v is DefaultValueNode)
      return Kind.DefaultValue;
    else if (v is DirectiveDefinitionNode)
      return Kind.DirectiveDefinition;
    else if (v is DirectiveNode)
      return Kind.Directive;
    else if (v is DocumentNode)
      return Kind.Document;
    else if (v is EnumTypeDefinitionNode)
      return Kind.EnumTypeDefinition;
    else if (v is EnumTypeExtensionNode)
      return Kind.EnumTypeExtension;
    else if (v is EnumValueDefinitionNode)
      return Kind.EnumValueDefinition;
    else if (v is EnumValueNode)
      return Kind.EnumValue;
    else if (v is FieldDefinitionNode)
      return Kind.FieldDefinition;
    else if (v is FieldNode)
      return Kind.Field;
    else if (v is FloatValueNode)
      return Kind.FloatValue;
    else if (v is FragmentDefinitionNode)
      return Kind.FragmentDefinition;
    else if (v is FragmentSpreadNode)
      return Kind.FragmentSpread;
    else if (v is InlineFragmentNode)
      return Kind.InlineFragment;
    else if (v is InputObjectTypeDefinitionNode)
      return Kind.InputObjectTypeDefinition;
    else if (v is InputObjectTypeExtensionNode)
      return Kind.InputObjectTypeExtension;
    else if (v is InputValueDefinitionNode)
      return Kind.InputValueDefinition;
    else if (v is IntValueNode)
      return Kind.IntValue;
    else if (v is InterfaceTypeDefinitionNode)
      return Kind.InterfaceTypeDefinition;
    else if (v is InterfaceTypeExtensionNode)
      return Kind.InterfaceTypeExtension;
    else if (v is ListTypeNode)
      return Kind.ListType;
    else if (v is ListValueNode)
      return Kind.ListValue;
    else if (v is NameNode)
      return Kind.Name;
    else if (v is NamedTypeNode)
      return Kind.NamedType;
    else if (v is NullValueNode)
      return Kind.NullValue;
    else if (v is ObjectFieldNode)
      return Kind.ObjectField;
    else if (v is ObjectTypeDefinitionNode)
      return Kind.ObjectTypeDefinition;
    else if (v is ObjectTypeExtensionNode)
      return Kind.ObjectTypeExtension;
    else if (v is ObjectValueNode)
      return Kind.ObjectValue;
    else if (v is OperationDefinitionNode)
      return Kind.OperationDefinition;
    else if (v is OperationTypeDefinitionNode)
      return Kind.OperationTypeDefinition;
    else if (v is ScalarTypeDefinitionNode)
      return Kind.ScalarTypeDefinition;
    else if (v is ScalarTypeExtensionNode)
      return Kind.ScalarTypeExtension;
    else if (v is SchemaDefinitionNode)
      return Kind.SchemaDefinition;
    else if (v is SchemaExtensionNode)
      return Kind.SchemaExtension;
    else if (v is SelectionSetNode)
      return Kind.SelectionSet;
    else if (v is StringValueNode)
      return Kind.StringValue;
    else if (v is TypeConditionNode)
      return Kind.TypeCondition;
    else if (v is UnionTypeDefinitionNode)
      return Kind.UnionTypeDefinition;
    else if (v is UnionTypeExtensionNode)
      return Kind.UnionTypeExtension;
    else if (v is VariableDefinitionNode)
      return Kind.VariableDefinition;
    else if (v is VariableNode) return Kind.Variable;

    throw Error();
  }

  NameNode? get nameNode {
    final v = this;
    if (v is ArgumentNode)
      return v.name;
    else if (v is BooleanValueNode)
      return null;
    else if (v is DefaultValueNode)
      return null;
    else if (v is DirectiveDefinitionNode)
      return v.name;
    else if (v is DirectiveNode)
      return v.name;
    else if (v is DocumentNode)
      return null;
    else if (v is EnumTypeDefinitionNode)
      return v.name;
    else if (v is EnumTypeExtensionNode)
      return v.name;
    else if (v is EnumValueDefinitionNode)
      return v.name;
    else if (v is EnumValueNode)
      return v.name;
    else if (v is FieldDefinitionNode)
      return v.name;
    else if (v is FieldNode)
      return v.name;
    else if (v is FloatValueNode)
      return null;
    else if (v is FragmentDefinitionNode)
      return v.name;
    else if (v is FragmentSpreadNode)
      return v.name;
    else if (v is InlineFragmentNode)
      return null;
    else if (v is InputObjectTypeDefinitionNode)
      return v.name;
    else if (v is InputObjectTypeExtensionNode)
      return v.name;
    else if (v is InputValueDefinitionNode)
      return v.name;
    else if (v is IntValueNode)
      return null;
    else if (v is InterfaceTypeDefinitionNode)
      return v.name;
    else if (v is InterfaceTypeExtensionNode)
      return v.name;
    else if (v is ListTypeNode)
      return null;
    else if (v is ListValueNode)
      return null;
    else if (v is NameNode)
      return v;
    else if (v is NamedTypeNode)
      return v.name;
    else if (v is NullValueNode)
      return null;
    else if (v is ObjectFieldNode)
      return v.name;
    else if (v is ObjectTypeDefinitionNode)
      return v.name;
    else if (v is ObjectTypeExtensionNode)
      return v.name;
    else if (v is ObjectValueNode)
      return null;
    else if (v is OperationDefinitionNode)
      return v.name;
    else if (v is OperationTypeDefinitionNode)
      return v.type.name;
    else if (v is ScalarTypeDefinitionNode)
      return v.name;
    else if (v is ScalarTypeExtensionNode)
      return v.name;
    else if (v is SchemaDefinitionNode)
      return null;
    else if (v is SchemaExtensionNode)
      return null;
    else if (v is SelectionSetNode)
      return null;
    else if (v is StringValueNode)
      return null;
    else if (v is TypeConditionNode)
      return v.on.name;
    else if (v is UnionTypeDefinitionNode)
      return v.name;
    else if (v is UnionTypeExtensionNode)
      return v.name;
    else if (v is VariableDefinitionNode)
      return v.variable.name;
    else if (v is VariableNode) return v.name;
    return null;
  }

  List<DirectiveNode>? get directivesNodes {
    final v = this;
    if (v is ArgumentNode)
      return null;
    else if (v is BooleanValueNode)
      return null;
    else if (v is DefaultValueNode)
      return null;
    else if (v is DirectiveDefinitionNode)
      return null;
    else if (v is DirectiveNode)
      return null;
    else if (v is DocumentNode)
      return null;
    else if (v is EnumTypeDefinitionNode)
      return v.directives;
    else if (v is EnumTypeExtensionNode)
      return v.directives;
    else if (v is EnumValueDefinitionNode)
      return v.directives;
    else if (v is EnumValueNode)
      return null;
    else if (v is FieldDefinitionNode)
      return v.directives;
    else if (v is FieldNode)
      return v.directives;
    else if (v is FloatValueNode)
      return null;
    else if (v is FragmentDefinitionNode)
      return v.directives;
    else if (v is FragmentSpreadNode)
      return v.directives;
    else if (v is InlineFragmentNode)
      return v.directives;
    else if (v is InputObjectTypeDefinitionNode)
      return v.directives;
    else if (v is InputObjectTypeExtensionNode)
      return v.directives;
    else if (v is InputValueDefinitionNode)
      return v.directives;
    else if (v is IntValueNode)
      return null;
    else if (v is InterfaceTypeDefinitionNode)
      return v.directives;
    else if (v is InterfaceTypeExtensionNode)
      return v.directives;
    else if (v is ListTypeNode)
      return null;
    else if (v is ListValueNode)
      return null;
    else if (v is NameNode)
      return null;
    else if (v is NamedTypeNode)
      return null;
    else if (v is NullValueNode)
      return null;
    else if (v is ObjectFieldNode)
      return null;
    else if (v is ObjectTypeDefinitionNode)
      return v.directives;
    else if (v is ObjectTypeExtensionNode)
      return v.directives;
    else if (v is ObjectValueNode)
      return null;
    else if (v is OperationDefinitionNode)
      return v.directives;
    else if (v is OperationTypeDefinitionNode)
      return null;
    else if (v is ScalarTypeDefinitionNode)
      return v.directives;
    else if (v is ScalarTypeExtensionNode)
      return v.directives;
    else if (v is SchemaDefinitionNode)
      return v.directives;
    else if (v is SchemaExtensionNode)
      return v.directives;
    else if (v is SelectionSetNode)
      return null;
    else if (v is StringValueNode)
      return null;
    else if (v is TypeConditionNode)
      return null;
    else if (v is UnionTypeDefinitionNode)
      return v.directives;
    else if (v is UnionTypeExtensionNode)
      return v.directives;
    else if (v is VariableDefinitionNode)
      return v.directives;
    else if (v is VariableNode) return null;
    return null;
  }
}
