DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS follows;

CREATE TABLE follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  follow_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (follow_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subject_id INTEGER NOT NULL,
  parent_id INTEGER,
  reply_body TEXT NOT NULL,
  reply_author_id INTEGER NOT NULL,
  FOREIGN KEY (subject_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (reply_author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS likes;

CREATE TABLE likes (
  id INTEGER PRIMARY KEY,
  liker INTEGER NOT NULL,
  question_liked INTEGER NOT NULL,
  FOREIGN KEY (liker) REFERENCES users(id),
  FOREIGN KEY (question_liked) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES 
  ("Bob", "Smith"), ("Adam", "Sandler"), ("Peter", "Piper");

INSERT INTO
  questions (title, body, author_id)
VALUES 
  ('bobs question', 'How do I commit?', 1),
  ('adams question', 'Assessment question?', 2),
  ('adams second question', 'Lunchtime?', 2);

INSERT INTO
  follows (question_id, follow_id)
VALUES 
  (1, 2), (2, 1), (1, 1), (1, 3), (2, 3);

INSERT INTO
  replies (subject_id, parent_id, reply_body, reply_author_id)
VALUES
  (1, NULL, "Learn git", 2), (1, 1, "Thanks", 1), (3, NULL, "Not yet", 3);

INSERT INTO
  likes (liker, question_liked)
VALUES
  (1, 1), (2, 2), (1, 2), (3, 2);