const subscriptionQuery = '''
subscription onEvent {
  onEvent {
    ...BaseEvent
  }
}

fragment BaseEvent on DBEvent {
  id
  type
  userId
  sessionId
  createdAt
  data {
    __typename
    ... on ChatMessageDBEventData {
      ...BaseChatMessageDBEventData
    }
  }
}
        
fragment BaseChatMessageDBEventData on ChatMessageDBEventData {
  value {
    ... on ChatMessageSentEvent {
      message {
        ...FullMessage
      }
    }
  }
}

fragment FullMessage on ChatMessage {
  ...BaseMessage
  referencedMessage {
    ...BaseMessage
  }
}

fragment BaseMessage on ChatMessage {
  id
  chatId
  userId
  message
  type
  fileUrl
  createdAt
}''';

// TOOD: test message metadata

const messagesQuery = r'''
query getMessages($chatId: Int!) {
  getMessage(chatId: $chatId) {
    ...FullMessage
  }
}

mutation sendMessage(
  $chatId: Int!
  $message: String!
  $referencedMessageId: Int
) {
  sendMessage(
    chatId: $chatId
    message: $message
    referencedMessageId: $referencedMessageId
  ) {
    ...FullMessage
  }
}

mutation sendFileMessage(
  $chatId: Int!
  $message: String
  $file: Upload!
  $referencedMessageId: Int
) {
  sendFileMessage(
    chatId: $chatId
    message: $message
    file: $file
    referencedMessageId: $referencedMessageId
  ) {
    ...FullMessage
  }
}

query getMessageLinksMetadata($message: String!) {
  getMessageLinksMetadata(message: $message) {
    ...MsgLinkMetadata
  }
}

fragment FullMessage on ChatMessage {
  ...BaseMessage
  referencedMessage {
    ...BaseMessage
  }
}

fragment BaseMessage on ChatMessage {
  id
  chatId
  userId
  message
  type
  fileUrl
  createdAt
}

fragment MsgLinkMetadata on LinksMetadata {
  links {
    title
    description
    image
    url
  }
  emails
  userTags
  hasLinks
}''';

const roomQueries = r'''
mutation createRoom($name: String!) {
  createChatRoom(name: $name) {
    ...FullChatRoom
  }
}

mutation deleteRoom($id: Int!) {
  deleteChatRoom(id: $id)
}

query getRooms {
  getChatRooms {
    ...FullChatRoom
  }
}

query searchUser($name: String!) {
  searchUser(name: $name) {
    ...AUser
  }
}

mutation addChatRoomUser(
  $role: ChatRoomUserRole
  $chatId: Int!
  $userId: Int!
) {
  addChatRoomUser(chatId: $chatId, userId: $userId, role: $role) {
    ...UserChat
  }
}

mutation deleteChatRoomUser($chatId: Int!, $userId: Int!) {
  deleteChatRoomUser(chatId: $chatId, userId: $userId)
}

fragment UserChat on ChatRoomUser {
  userId
  chatId
  role
  user {
    ...AUser
  }
}

fragment AUser on User {
  id
  name
}

fragment FullChatRoom on ChatRoom {
  ...BaseChatRoom
  users {
    ...UserChat
  }
}
fragment BaseChatRoom on ChatRoom {
  id
  name
  createdAt
}''';
