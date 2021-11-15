import 'package:gql/ast.dart';

typedef VisitFunc<N extends Node> = VisitBehavior? Function(N);

enum VisitBehavior {
  skipTree,
  stop,
}

class VisitNodeCallbacks<N extends Node> {
  final VisitFunc<N>? _enter;
  final VisitFunc<N>? _leave;

  const VisitNodeCallbacks(this._enter, this._leave);

  VisitBehavior? enter(N node) => _enter?.call(node);
  VisitBehavior? leave(N node) => _leave?.call(node);

  Type get nodeType => N;
}

/// A recursive [Visitor] calling [Node.visitChildren] to make sure every node is visited.
///
/// When extending any of the visit methods you are responsible for calling the same
/// visit method on `super` to make sure the whole AST is visited.
class TypedVisitor extends WrapperVisitor<void> {
  final _visitors = <Type, List<VisitNodeCallbacks>>{};

  void add<N extends Node>(VisitFunc<N> enter, {VisitFunc<N>? leave}) {
    final obj = VisitNodeCallbacks<N>(enter, leave);
    addObj(obj);
  }

  void addObj<N extends Node>(VisitNodeCallbacks<N> obj) {
    final nodeVisitors = _visitors.putIfAbsent(N, () => []);
    nodeVisitors.add(obj);
  }

  void mergeInPlace(TypedVisitor other) {
    other._visitors.forEach((key, value) {
      final list = _visitors.putIfAbsent(key, () => []);
      list.addAll(value);
    });
  }

  List<VisitNodeCallbacks<Node>>? defaultVisitors() => _visitors[Node];

  @override
  void visitNode<N extends Node>(N node) {
    enter(node);
    node.visitChildren(this);
    leave(node);
  }

  Node? _skippedNode;
  bool _stopped = false;

  List<VisitNodeCallbacks> _visitorsFor<N extends Node>() {
    final nodeVisitors = _visitors[N];
    final _defaultVisitors = defaultVisitors();

    return [
      if (nodeVisitors != null) ...nodeVisitors,
      if (_defaultVisitors != null) ..._defaultVisitors,
    ];
  }

  void enter<N extends Node>(N node) {
    if (_skippedNode != null || _stopped) return;

    final nodeVisitors = _visitorsFor<N>();
    for (final visitor in nodeVisitors) {
      final value = visitor.enter(node);
      if (value == VisitBehavior.skipTree) {
        _skippedNode = node;
      } else if (value == VisitBehavior.stop) {
        _stopped = true;
      }
    }
  }

  // void _skipVisitor(Node node, VisitNodeCallbacks visitor) {
  //   _skippedStack[_skippedStack.length - 1].add(visitor);
  //   _allSkipped.add(visitor);
  // }

  void leave<N extends Node>(N node) {
    if (_stopped) return;
    if (_skippedNode != null) {
      if (node == _skippedNode) {
        _skippedNode = null;
      } else {
        return;
      }
    }
    // for (final visitor in list) {
    //   _allSkipped.remove(visitor);
    // }

    final nodeVisitors = _visitorsFor<N>();
    for (final visitor in nodeVisitors) {
      final value = visitor.leave(node);
      if (value == VisitBehavior.stop) {
        _stopped = true;
      }
    }
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
