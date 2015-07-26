class Follow
  def self.all_follows
    follows = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      *
    FROM
      follows
    SQL
    follows.map { |follow| Follow.new(follow) }
  end

  attr_accessor :id, :question_id, :follow_id

  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @follow_id = options['follow_id']
  end

  def create
    raise 'already saved!' unless self.id.nil?
    sql_query = <<-SQL
    INSERT INTO
      follows (question_id, follow_id)
    VALUES
      (:question_id, :follow_id)
    SQL
    QuestionsDatabase.instance.execute(
                                         sql_query,
                                         question_id: question_id,
                                         author_id: author_id
                                       )

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.find_by_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      follows
    WHERE
      id = :id
    LIMIT
      1
    SQL

    Follow.new(options.first)
  end

  def self.followers_for_question_id(question_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
    SELECT
      u.*
    FROM
      users u
    JOIN
      follows ON u.id = follows.follow_id
    WHERE
      follows.question_id = :question_id
    SQL

    options.map { |user_option| User.new(user_option) }
  end

  def self.followed_questions_for_user_id(user_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
    SELECT
      q.*
    FROM
      questions q
    JOIN
      follows ON q.id = follows.question_id
    WHERE
      follows.follow_id = :user_id
    SQL

    options.map { |question_option| Question.new(question_option) }
  end

  def self.most_followed_questions(n)
    options = QuestionsDatabase.instance.execute(<<-SQL, n: n)
    SELECT
      q.*
    FROM
      questions q
    JOIN
      follows ON q.id = follows.question_id
    GROUP BY
      q.id
    ORDER BY
      COUNT(follows.question_id) DESC
    LIMIT
      :n
    SQL
    options.map { |question_option| Question.new(question_option) }
  end
end