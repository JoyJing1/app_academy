DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  author_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  parent_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO
  users (fname, lname)
VALUES
  ('Joy', 'Jing'),
  ('Ken', 'Cha'),
  ('Jasper', 'Chen'),
  ('Joe', 'Kim'),
  ('John', 'Kim');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('How Are You?', 'How are you today, madam sir', (SELECT id FROM users WHERE fname = 'Ken')),
  ('What''s Up', 'How''s the weather up there?', (SELECT id FROM users WHERE fname = 'Joy'));

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'How Are You?'),
    (SELECT id FROM users WHERE fname = 'Jasper')),

  ((SELECT id FROM questions WHERE title = 'How Are You?'),
    (SELECT id FROM users WHERE fname = 'Joy')),

  ((SELECT id FROM questions WHERE title = 'What''s Up'),
    (SELECT id FROM users WHERE fname = 'Joe')),

  ((SELECT id FROM questions WHERE title = 'What''s Up'),
    (SELECT id FROM users WHERE fname = 'John'));


INSERT INTO
  replies (question_id, author_id, body, parent_id)
VALUES
  (1, 2, 'Reply number 1', 1),
  (2, 3, 'Reply number 2', 1),
  (3, 1, 'Reply number 3', 1),
  (1, 2, 'Reply number 4', 2);


INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (1, 1),
  (2, 2),
  (1, 4),
  (2, 3),
  (1, 2);
