class QuestionLike
  attr_accessor :question_id, :user_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| QuestionLike.new(datum) }
  end

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
    SELECT
      *
    FROM
      question_likes
    WHERE
      id = ?
    SQL

    QuestionLike.new(question)
  end

  def self.likers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      u.*
    FROM
      question_likes ql
      JOIN users u
        ON u.id = ql.user_id
    WHERE
      ql.question_id = ?
    SQL
    data.map { |datum| User.new(datum) }
  end

  def initialize(options)
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.num_likes_for_question_id(question_id)
    QuestionsDatabase.instance.get_first_value(<<-SQL, question_id)
    SELECT
      COUNT(*)
    FROM
      question_likes
    WHERE
      question_id = ?
    SQL
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      q.*
    FROM
      questions q
      JOIN question_likes ql
      ON q.id = ql.question_id
    WHERE
      ql.user_id = ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      q.*
    FROM
      questions q
      LEFT JOIN question_likes ql
        ON q.id = ql.question_id
    GROUP BY
      q.id
    ORDER BY
      COUNT(ql.user_id) DESC
    LIMIT ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

end
