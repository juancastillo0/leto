import 'package:gql/ast.dart';

typedef VisitFunc<N extends Node> = void Function(N);

class VisitNodeCallbacks<N extends Node> {
  final VisitFunc<N>? _enter;
  final VisitFunc<N>? _leave;

  const VisitNodeCallbacks(this._enter, this._leave);

  void enter(N node) => _enter?.call(node);
  void leave(N node) => _leave?.call(node);

  Type get nodeType => N;
}

/// A recursive [Visitor] calling [Node.visitChildren] to make sure every node is visited.
///
/// When extending any of the visit methods you are responsible for calling the same
/// visit method on `super` to make sure the whole AST is visited.
class TypedVisitor extends WrapperVisitor<void> {
  final _visitors = <Type, List<VisitNodeCallbacks>>{};

  @override
  void visitNode<N extends Node>(N node) {
    final nodeVisitors = _visitors[N];
    if (nodeVisitors != null) {
      for (final visitor in nodeVisitors) {
        visitor.enter(node);
      }
      // node.visitChildren(this);
      // for (final visitor in nodeVisitors) {
      //   visitor.leave?.call(node);
      // }
    } else {
      // node.visitChildren(this);
    }
  }

  void add<N extends Node>(VisitFunc<N> enter, [VisitFunc<N>? leave]) {
    final obj = VisitNodeCallbacks<N>(enter, leave);
    addObj(obj);
  }

  void addObj<N extends Node>(VisitNodeCallbacks<N> obj) {
    final nodeVisitors = _visitors.putIfAbsent(N, () => []);
    nodeVisitors.add(obj);
  }
}

/// A [Visitor] that calls [WrapperVisitor.visitNode] for all nodes
abstract class WrapperVisitor<T> implements Visitor<T> {
  /// Called for every node in the ast
  T visitNode<N extends Node>(N node);

  @override
  T visitArgumentNode(
    ArgumentNode node,
  ) =>
      visitNode(node);

  @override
  T visitBooleanValueNode(
    BooleanValueNode node,
  ) =>
      visitNode(node);

  @override
  T visitDefaultValueNode(
    DefaultValueNode node,
  ) =>
      visitNode(node);

  @override
  T visitDirectiveDefinitionNode(
    DirectiveDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitDirectiveNode(
    DirectiveNode node,
  ) =>
      visitNode(node);

  @override
  T visitDocumentNode(
    DocumentNode node,
  ) =>
      visitNode(node);

  @override
  T visitEnumTypeDefinitionNode(
    EnumTypeDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitEnumTypeExtensionNode(
    EnumTypeExtensionNode node,
  ) =>
      visitNode(node);

  @override
  T visitEnumValueDefinitionNode(
    EnumValueDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitEnumValueNode(
    EnumValueNode node,
  ) =>
      visitNode(node);

  @override
  T visitFieldDefinitionNode(
    FieldDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitFieldNode(
    FieldNode node,
  ) =>
      visitNode(node);

  @override
  T visitFloatValueNode(
    FloatValueNode node,
  ) =>
      visitNode(node);

  @override
  T visitFragmentDefinitionNode(
    FragmentDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitFragmentSpreadNode(
    FragmentSpreadNode node,
  ) =>
      visitNode(node);

  @override
  T visitInlineFragmentNode(
    InlineFragmentNode node,
  ) =>
      visitNode(node);

  @override
  T visitInputObjectTypeDefinitionNode(
    InputObjectTypeDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitInputObjectTypeExtensionNode(
    InputObjectTypeExtensionNode node,
  ) =>
      visitNode(node);

  @override
  T visitInputValueDefinitionNode(
    InputValueDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitIntValueNode(
    IntValueNode node,
  ) =>
      visitNode(node);

  @override
  T visitInterfaceTypeDefinitionNode(
    InterfaceTypeDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitInterfaceTypeExtensionNode(
    InterfaceTypeExtensionNode node,
  ) =>
      visitNode(node);

  @override
  T visitListTypeNode(
    ListTypeNode node,
  ) =>
      visitNode(node);

  @override
  T visitListValueNode(
    ListValueNode node,
  ) =>
      visitNode(node);

  @override
  T visitNameNode(
    NameNode node,
  ) =>
      visitNode(node);

  @override
  T visitNamedTypeNode(
    NamedTypeNode node,
  ) =>
      visitNode(node);

  @override
  T visitNullValueNode(
    NullValueNode node,
  ) =>
      visitNode(node);

  @override
  T visitObjectFieldNode(
    ObjectFieldNode node,
  ) =>
      visitNode(node);

  @override
  T visitObjectTypeDefinitionNode(
    ObjectTypeDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitObjectTypeExtensionNode(
    ObjectTypeExtensionNode node,
  ) =>
      visitNode(node);

  @override
  T visitObjectValueNode(
    ObjectValueNode node,
  ) =>
      visitNode(node);

  @override
  T visitOperationDefinitionNode(
    OperationDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitOperationTypeDefinitionNode(
    OperationTypeDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitScalarTypeDefinitionNode(
    ScalarTypeDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitScalarTypeExtensionNode(
    ScalarTypeExtensionNode node,
  ) =>
      visitNode(node);

  @override
  T visitSchemaDefinitionNode(
    SchemaDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitSchemaExtensionNode(
    SchemaExtensionNode node,
  ) =>
      visitNode(node);

  @override
  T visitSelectionSetNode(
    SelectionSetNode node,
  ) =>
      visitNode(node);

  @override
  T visitStringValueNode(
    StringValueNode node,
  ) =>
      visitNode(node);

  @override
  T visitTypeConditionNode(
    TypeConditionNode node,
  ) =>
      visitNode(node);

  @override
  T visitUnionTypeDefinitionNode(
    UnionTypeDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitUnionTypeExtensionNode(
    UnionTypeExtensionNode node,
  ) =>
      visitNode(node);

  @override
  T visitVariableDefinitionNode(
    VariableDefinitionNode node,
  ) =>
      visitNode(node);

  @override
  T visitVariableNode(
    VariableNode node,
  ) =>
      visitNode(node);
}
