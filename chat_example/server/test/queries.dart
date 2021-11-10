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
