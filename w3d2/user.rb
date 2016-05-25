require 'sqlite3'
require 'singleton'
require 'byebug'
require_relative 'modelbase'

class User < ModelBase
  attr_accessor :fname, :lname
  attr_reader :table_name

  def self.all
    super
  end

  def self.find_by_id(id)
    super(id)
  end


  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.get_first_row(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ?
    AND
      lname = ?
    SQL

    User.new(user)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
    @table_name = 'users'
  end

  def save
    super
  end
  
  #
  # def save
  #   if @id
  #     QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
  #     UPDATE
  #       users
  #     SET
  #       fname = ?,
  #       lname = ?
  #     WHERE
  #       id = ?
  #     SQL
  #   else
  #     QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
  #     INSERT INTO
  #       users (fname, lname)
  #     VALUES
  #       (?, ?)
  #     SQL
  #     @id = QuestionsDatabase.instance.last_insert_row_id
  #   end
  # end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    QuestionsDatabase.instance.get_first_value(<<-SQL, @id)
    SELECT
      CAST(COUNT(ql.user_id) AS FLOAT) / COUNT(DISTINCT q.id)
    FROM
      users u
      JOIN questions q
        ON u.id = q.author_id
      LEFT JOIN question_likes ql
        ON ql.question_id = q.id
    WHERE
      u.id = ?
    SQL
  end

end
