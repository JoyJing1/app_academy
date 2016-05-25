require_relative 'modelbase'

class Reply < ModelBase
  attr_accessor :question_id, :author_id, :body, :parent_id

  def self.all
    super
  end

  def self.find_by_id(id)
    super(id)
  end

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      author_id = ?
    SQL
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL
    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @author_id = options['author_id']
    @body = options['body']
    @parent_id = options['parent_id']
  end

  def author
    User.find_by_id(@author_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    data = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_id = ?
    SQL
    data.map { |datum| Reply.new(datum) }
  end

  def save
    super
  end
  
  # def save
  #   if @id
  #     QuestionsDatabase.instance.execute(<<-SQL, @question_id, @author_id, @body, @parent_id, @id)
  #     UPDATE
  #       replies
  #     SET
  #       question_id = ?,
  #       author_id = ?,
  #       body = ?,
  #       parent_id = ?
  #     WHERE
  #       id = ?
  #     SQL
  #   else
  #     data = QuestionsDatabase.instance.execute(<<-SQL, @question_id, @author_id, @body, @parent_id)
  #     INSERT INTO
  #       replies (question_id, author_id, body, parent_id)
  #     VALUES
  #       (?, ?, ?, ?)
  #     SQL
  #     @id = QuestionsDatabase.instance.last_insert_row_id
  #   end
  # end

end
