require 'singleton'
require 'sqlite3'
require_relative 'questions'
require_relative 'reply'

class User
  def self.all
    user = QuestionsDatabase.instance.execute("SELECT * FROM users")
    user.map { |datum| User.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def save
    @id ? update : create
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
  end

  def create
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
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

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ?
          AND
        lname = ?
      SQL
      raise "That id has no information in the database" if user.empty?
      User.new(user.first)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollows.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    user = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
    CAST((COUNT(question_likes.user_id) / COUNT(DISTINCT(questions.id))) AS FLOAT)
    FROM
    questions
    LEFT OUTER JOIN question_likes ON questions.id = question_likes.question_id
    WHERE
    questions.author_id = ?
    GROUP BY
    questions.id
    SQL

    user.first.values.first
  end

end
