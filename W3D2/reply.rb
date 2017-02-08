require 'singleton'
require 'sqlite3'
require_relative 'questions'
require_relative 'user'

class Reply

  def self.all
    reply = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    reply.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @subject_question_id = options['subject_question_id']
    @parent_reply_id = options['parent_reply_id']
    @reply_author_id = options['reply_author_id']
    @body = options['body']
  end

  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
      SQL
      raise "That id has no information in the database" if reply.empty?
      Reply.new(reply.first)
  end

  def question
    question = QuestionsDatabase.instance.execute(<<-SQL, @subject_question_id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
      SQL
      raise "That id has no information in the database" if question.empty?
      Question.new(question.first)
  end

  def parent_reply
    parent = QuestionsDatabase.instance.execute(<<-SQL, @parent_reply_id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
      SQL
      return nil if parent.empty?
      Reply.new(parent.first)
  end

  def child_replies
    child = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
      SQL
      return nil if child.empty?
      Reply.new(child.first)
  end

  def author
    user = QuestionsDatabase.instance.execute(<<-SQL, @reply_author_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
      SQL
      raise "That id has no information in the database" if user.empty?
      User.new(user.first)
  end

  def self.find_by_user_id(user_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        reply_author_id = ?
      SQL
      raise "That id has no information in the database" if reply.empty?
      Reply.new(reply.first)
  end

  def self.find_by_question_id(question_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        subject_question_id = ?
      SQL
      raise "That id has no information in the database" if questions.empty?
      questions.map { |datum| Reply.new(datum) }
  end

end
