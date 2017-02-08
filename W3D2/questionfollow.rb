require 'singleton'
require 'sqlite3'
require_relative 'user'
require_relative 'reply'
require_relative 'questions'

class QuestionFollows

  def self.all
    follows = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    follows.map { |datum| QuestionFollows.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.find_by_id(id)
    follows = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL
    raise "That id has no information in the database" if follows.empty?
    QuestionFollows.new(follows.first)
  end

  def self.followers_for_question_id(question_id)
    follows = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
    users
    JOIN question_follows ON users.id = question_follows.user_id
    WHERE
      question_follows.question_id = ?
    SQL

    follows.map {|datum| User.new(datum)}
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
    questions
    JOIN question_follows ON questions.id = question_follows.question_id
    WHERE
      question_follows.user_id = ?
    SQL

    questions.map {|datum| Question.new(datum)}

  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      *
    FROM
    questions
    JOIN question_follows ON questions.id = question_follows.question_id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(*) DESC
    LIMIT ?
    SQL

    questions.map {|datum| Question.new(datum) }
  end


end
