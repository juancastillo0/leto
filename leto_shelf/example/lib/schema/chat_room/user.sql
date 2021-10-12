CREATE TABLE user (
    id INT NOT NULL,
    name TEXT NULL,
    password2 TEXT NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE userSession (
    sessionCode TEXT NOT NULL,
    userId INT NOT NULL,
    ip TEXT NOT NULL,
    userAgent TEXT NOT NULL,
    platform TEXT NOT NULL,
    appVersion TEXT NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES user (id),
    PRIMARY KEY (sessionCode)
);

CREATE TABLE chatRoomUser (
    userId INT NOT NULL,
    chatId INT NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (userId, chatId),
    FOREIGN KEY (userId) REFERENCES user (id),
    FOREIGN KEY (chatId) REFERENCES chat (id)
);