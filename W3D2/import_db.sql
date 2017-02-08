PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);
INSERT INTO "users" VALUES(1,'Richard','Feynman');
INSERT INTO "users" VALUES(2,'Carl','Sagan');
INSERT INTO "users" VALUES(3,'Neil','deGrasse Tyson');
INSERT INTO "users" VALUES(4,'Peter','Singer');
INSERT INTO "users" VALUES(5,'John','Stuart Mill');
DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);
INSERT INTO "questions" VALUES(1,'Apple Pie','How do you make an apple pie from scratch?',1);
INSERT INTO "questions" VALUES(2,'The Challenger','What went wrong?',3);
INSERT INTO "questions" VALUES(3,'Speciesism','What makes a person?',4);
DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);
INSERT INTO "question_follows" VALUES(1,3,1);
INSERT INTO "question_follows" VALUES(2,2,1);
INSERT INTO "question_follows" VALUES(3,1,2);
DROP TABLE IF EXISTS replies;
CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subject_question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  reply_author_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (subject_question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (reply_author_id) REFERENCES users(id)
);
INSERT INTO "replies" VALUES(1,1,NULL,2,'You must first invent the universe');
INSERT INTO "replies" VALUES(2,1,1,3,'Low-temperature O-rings.');
INSERT INTO "replies" VALUES(3,2,NULL,1,'More than species membership.');
DROP TABLE IF EXISTS question_likes;
CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);
INSERT INTO "question_likes" VALUES(1,2,1);
INSERT INTO "question_likes" VALUES(2,1,2);
INSERT INTO "question_likes" VALUES(3,3,1);
INSERT INTO "question_likes" VALUES(4,4,1);
INSERT INTO "question_likes" VALUES(5,4,2);
COMMIT;
