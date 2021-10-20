// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:chat_example/api/messages.ast.gql.dart' as _i2;
import 'package:chat_example/api/user.ast.gql.dart' as _i3;
import 'package:gql/ast.dart' as _i1;

const createRoom = _i1.OperationDefinitionNode(
    type: _i1.OperationType.mutation,
    name: _i1.NameNode(value: 'createRoom'),
    variableDefinitions: [
      _i1.VariableDefinitionNode(
          variable: _i1.VariableNode(name: _i1.NameNode(value: 'name')),
          type: _i1.NamedTypeNode(
              name: _i1.NameNode(value: 'String'), isNonNull: true),
          defaultValue: _i1.DefaultValueNode(value: null),
          directives: [])
    ],
    directives: [],
    selectionSet: _i1.SelectionSetNode(selections: [
      _i1.FieldNode(
          name: _i1.NameNode(value: 'createChatRoom'),
          alias: null,
          arguments: [
            _i1.ArgumentNode(
                name: _i1.NameNode(value: 'name'),
                value: _i1.VariableNode(name: _i1.NameNode(value: 'name')))
          ],
          directives: [],
          selectionSet: _i1.SelectionSetNode(selections: [
            _i1.FragmentSpreadNode(
                name: _i1.NameNode(value: 'BaseChatRoom'), directives: [])
          ]))
    ]));
const deleteRoom = _i1.OperationDefinitionNode(
    type: _i1.OperationType.mutation,
    name: _i1.NameNode(value: 'deleteRoom'),
    variableDefinitions: [
      _i1.VariableDefinitionNode(
          variable: _i1.VariableNode(name: _i1.NameNode(value: 'id')),
          type: _i1.NamedTypeNode(
              name: _i1.NameNode(value: 'Int'), isNonNull: true),
          defaultValue: _i1.DefaultValueNode(value: null),
          directives: [])
    ],
    directives: [],
    selectionSet: _i1.SelectionSetNode(selections: [
      _i1.FieldNode(
          name: _i1.NameNode(value: 'deleteChatRoom'),
          alias: null,
          arguments: [
            _i1.ArgumentNode(
                name: _i1.NameNode(value: 'id'),
                value: _i1.VariableNode(name: _i1.NameNode(value: 'id')))
          ],
          directives: [],
          selectionSet: null)
    ]));
const getRooms = _i1.OperationDefinitionNode(
    type: _i1.OperationType.query,
    name: _i1.NameNode(value: 'getRooms'),
    variableDefinitions: [],
    directives: [],
    selectionSet: _i1.SelectionSetNode(selections: [
      _i1.FieldNode(
          name: _i1.NameNode(value: 'getChatRooms'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: _i1.SelectionSetNode(selections: [
            _i1.FragmentSpreadNode(
                name: _i1.NameNode(value: 'FullChatRoom'), directives: [])
          ]))
    ]));
const searchUser = _i1.OperationDefinitionNode(
    type: _i1.OperationType.query,
    name: _i1.NameNode(value: 'searchUser'),
    variableDefinitions: [
      _i1.VariableDefinitionNode(
          variable: _i1.VariableNode(name: _i1.NameNode(value: 'name')),
          type: _i1.NamedTypeNode(
              name: _i1.NameNode(value: 'String'), isNonNull: true),
          defaultValue: _i1.DefaultValueNode(value: null),
          directives: [])
    ],
    directives: [],
    selectionSet: _i1.SelectionSetNode(selections: [
      _i1.FieldNode(
          name: _i1.NameNode(value: 'searchUser'),
          alias: null,
          arguments: [
            _i1.ArgumentNode(
                name: _i1.NameNode(value: 'name'),
                value: _i1.VariableNode(name: _i1.NameNode(value: 'name')))
          ],
          directives: [],
          selectionSet: _i1.SelectionSetNode(selections: [
            _i1.FragmentSpreadNode(
                name: _i1.NameNode(value: 'AUser'), directives: [])
          ]))
    ]));
const addChatRoomUser = _i1.OperationDefinitionNode(
    type: _i1.OperationType.mutation,
    name: _i1.NameNode(value: 'addChatRoomUser'),
    variableDefinitions: [
      _i1.VariableDefinitionNode(
          variable: _i1.VariableNode(name: _i1.NameNode(value: 'role')),
          type: _i1.NamedTypeNode(
              name: _i1.NameNode(value: 'ChatRoomUserRole'), isNonNull: false),
          defaultValue: _i1.DefaultValueNode(value: null),
          directives: []),
      _i1.VariableDefinitionNode(
          variable: _i1.VariableNode(name: _i1.NameNode(value: 'chatId')),
          type: _i1.NamedTypeNode(
              name: _i1.NameNode(value: 'Int'), isNonNull: true),
          defaultValue: _i1.DefaultValueNode(value: null),
          directives: []),
      _i1.VariableDefinitionNode(
          variable: _i1.VariableNode(name: _i1.NameNode(value: 'userId')),
          type: _i1.NamedTypeNode(
              name: _i1.NameNode(value: 'Int'), isNonNull: true),
          defaultValue: _i1.DefaultValueNode(value: null),
          directives: [])
    ],
    directives: [],
    selectionSet: _i1.SelectionSetNode(selections: [
      _i1.FieldNode(
          name: _i1.NameNode(value: 'addChatRoomUser'),
          alias: null,
          arguments: [
            _i1.ArgumentNode(
                name: _i1.NameNode(value: 'chatId'),
                value: _i1.VariableNode(name: _i1.NameNode(value: 'chatId'))),
            _i1.ArgumentNode(
                name: _i1.NameNode(value: 'userId'),
                value: _i1.VariableNode(name: _i1.NameNode(value: 'userId'))),
            _i1.ArgumentNode(
                name: _i1.NameNode(value: 'role'),
                value: _i1.VariableNode(name: _i1.NameNode(value: 'role')))
          ],
          directives: [],
          selectionSet: _i1.SelectionSetNode(selections: [
            _i1.FragmentSpreadNode(
                name: _i1.NameNode(value: 'UserChat'), directives: [])
          ]))
    ]));
const deleteChatRoomUser = _i1.OperationDefinitionNode(
    type: _i1.OperationType.mutation,
    name: _i1.NameNode(value: 'deleteChatRoomUser'),
    variableDefinitions: [
      _i1.VariableDefinitionNode(
          variable: _i1.VariableNode(name: _i1.NameNode(value: 'chatId')),
          type: _i1.NamedTypeNode(
              name: _i1.NameNode(value: 'Int'), isNonNull: true),
          defaultValue: _i1.DefaultValueNode(value: null),
          directives: []),
      _i1.VariableDefinitionNode(
          variable: _i1.VariableNode(name: _i1.NameNode(value: 'userId')),
          type: _i1.NamedTypeNode(
              name: _i1.NameNode(value: 'Int'), isNonNull: true),
          defaultValue: _i1.DefaultValueNode(value: null),
          directives: [])
    ],
    directives: [],
    selectionSet: _i1.SelectionSetNode(selections: [
      _i1.FieldNode(
          name: _i1.NameNode(value: 'deleteChatRoomUser'),
          alias: null,
          arguments: [
            _i1.ArgumentNode(
                name: _i1.NameNode(value: 'chatId'),
                value: _i1.VariableNode(name: _i1.NameNode(value: 'chatId'))),
            _i1.ArgumentNode(
                name: _i1.NameNode(value: 'userId'),
                value: _i1.VariableNode(name: _i1.NameNode(value: 'userId')))
          ],
          directives: [],
          selectionSet: null)
    ]));
const UserChat = _i1.FragmentDefinitionNode(
    name: _i1.NameNode(value: 'UserChat'),
    typeCondition: _i1.TypeConditionNode(
        on: _i1.NamedTypeNode(
            name: _i1.NameNode(value: 'ChatRoomUser'), isNonNull: false)),
    directives: [],
    selectionSet: _i1.SelectionSetNode(selections: [
      _i1.FieldNode(
          name: _i1.NameNode(value: 'userId'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      _i1.FieldNode(
          name: _i1.NameNode(value: 'chatId'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      _i1.FieldNode(
          name: _i1.NameNode(value: 'role'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      _i1.FieldNode(
          name: _i1.NameNode(value: 'user'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: _i1.SelectionSetNode(selections: [
            _i1.FragmentSpreadNode(
                name: _i1.NameNode(value: 'AUser'), directives: [])
          ]))
    ]));
const FullChatRoom = _i1.FragmentDefinitionNode(
    name: _i1.NameNode(value: 'FullChatRoom'),
    typeCondition: _i1.TypeConditionNode(
        on: _i1.NamedTypeNode(
            name: _i1.NameNode(value: 'ChatRoom'), isNonNull: false)),
    directives: [],
    selectionSet: _i1.SelectionSetNode(selections: [
      _i1.FragmentSpreadNode(
          name: _i1.NameNode(value: 'BaseChatRoom'), directives: []),
      _i1.FieldNode(
          name: _i1.NameNode(value: 'users'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: _i1.SelectionSetNode(selections: [
            _i1.FragmentSpreadNode(
                name: _i1.NameNode(value: 'UserChat'), directives: [])
          ]))
    ]));
const BaseChatRoom = _i1.FragmentDefinitionNode(
    name: _i1.NameNode(value: 'BaseChatRoom'),
    typeCondition: _i1.TypeConditionNode(
        on: _i1.NamedTypeNode(
            name: _i1.NameNode(value: 'ChatRoom'), isNonNull: false)),
    directives: [],
    selectionSet: _i1.SelectionSetNode(selections: [
      _i1.FieldNode(
          name: _i1.NameNode(value: 'id'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      _i1.FieldNode(
          name: _i1.NameNode(value: 'name'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null),
      _i1.FieldNode(
          name: _i1.NameNode(value: 'createdAt'),
          alias: null,
          arguments: [],
          directives: [],
          selectionSet: null)
    ]));
const document = _i1.DocumentNode(definitions: [
  createRoom,
  deleteRoom,
  getRooms,
  searchUser,
  addChatRoomUser,
  deleteChatRoomUser,
  UserChat,
  FullChatRoom,
  BaseChatRoom,
  _i2.getMessages,
  _i2.sendMessage,
  _i2.onMessageSent,
  _i2.FullMessage,
  _i3.refreshAuthToken,
  _i3.signIn,
  _i3.signUp,
  _i3.signOut,
  _i3.AUser,
  _i3.STokenWithUser
]);
