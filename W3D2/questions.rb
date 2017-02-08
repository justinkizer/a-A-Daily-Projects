require 'singleton'
require 'sqlite3'
require_relative 'user'
require_relative 'reply'
require_relative 'questionfollow'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end

end


class Question

  def self.all
    question = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    question.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
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

  def self.find_by_author_id(author_id)
    question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL
    raise "That id has no information in the database" if question.empty?
    Question.new(question.first)
  end

  def author

    user = QuestionsDatabase.instance.execute(<<-SQL, @author_id)

      SELECT
        *
      FROM
       users
      WHERE
       id = ?
    SQL

    raise "That id has no information in the database" if question.empty?
    User.new(user.first)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollows.followers_for_question_id(@id)
  end

  def self.most_followed(n)
    QuestionFollows.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
end




class QuestionLike

  def self.all
    like = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    like.map { |datum| QuestionLike.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.find_by_id(id)
    like = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
      SQL
      raise "That id has no information in the database" if like.empty?
      QuestionLike.new(like.first)
  end

  def self.likers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN
        question_follows ON question_follows.user_id = users.id
      WHERE
        question_follows.question_id = ?
      SQL
      raise "Sorry, NO ONE LIKES THAT POST!" if users.empty?
      users.map {|datum| User.new(datum) }
  end

  def self.num_likes_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(users.id)
      FROM
        users
      JOIN
        question_follows ON question_follows.user_id = users.id
      WHERE
      question_follows.question_id = ?
      GROUP BY
      question_follows.question_id
      SQL

      users.first.values.first


  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        COUNT(questions.id)
      FROM
        questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      WHERE
      question_follows.user_id = ?
      GROUP BY
      question_follows.question_id
      SQL
      questions.first.values.first
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      *
    FROM
    questions
    JOIN question_likes ON questions.id = question_likes.question_id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(*) DESC
    LIMIT ?
    SQL

    questions.map {|datum| Question.new(datum) }
  end


end
