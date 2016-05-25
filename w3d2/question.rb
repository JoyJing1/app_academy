require_relative 'modelbase'

class Question < ModelBase
  attr_accessor :title, :body, :author_id

  def self.all
    super
  end

  def self.find_by_id(id)
    super(id)
  end

  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.get_first_row(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      author_id = ?
    SQL
    Question.new(data)
  end

  def self.most_followed
    QuestionFollow.most_followed_questions(1)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def save
    super
  end

  #
  # def save
  #   if @id
  #     QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id)
  #     UPDATE
  #       questions
  #     SET
  #       title = ?,
  #       body = ?,
  #       author_id = ?
  #     WHERE
  #       id = ?
  #     SQL
  #   else
  #     QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
  #     INSERT INTO
  #       questions (title, body, author_id)
  #     VALUES
  #       (?, ?, ?)
  #     SQL
  #     @id = QuestionsDatabase.instance.last_insert_row_id
  #   end
  # end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end


end
