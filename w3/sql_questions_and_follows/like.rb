class Like
  def self.all_likes
    likes = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      *
    FROM
      likes
    SQL
    likes.map { |like| Like.new(like) }
  end

  attr_accessor :id, :liker, :question_liked

  def initialize(options = {})
    @id = options['id']
    @liker = options['liker']
    @question_liked = options['question_liked']
  end

  def create
    raise 'already saved!' unless self.id.nil?
    sql_query = <<-SQL
    INSERT INTO
      likes (liker, question_liked)
    VALUES
      (:liker, :question_liked)
    SQL
    QuestionsDatabase.instance.execute(
                                        sql_query,
                                        liker: liker,
                                        question_liked: question_liked
                                        )

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.find_by_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      likes
    WHERE
      id = :id
    LIMIT
      1
    SQL
    Like.new(options.first)
  end

  def self.likers_for_question_id(question_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
    SELECT
      users.*
    FROM
      users
    JOIN
      likes ON likes.liker = users.id
    WHERE
      likes.question_liked = :question_id
    SQL
    options.map { |like| Like.new(like) }
  end

  def self.num_likes_for_question_id(question_id)
    num = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
    SELECT
      COUNT(*) AS count
    FROM
      users
    JOIN
      likes ON likes.liker = users.id
    WHERE
      likes.question_liked = :question_id
    SQL
    num.first['count']
  end

  def self.liked_questions_for_user_id(user_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
    SELECT
      questions.*
    FROM
      likes
    JOIN
      questions ON likes.question_liked = questions.id
    WHERE
      likes.liker = :user_id
    SQL

    options.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    options = QuestionsDatabase.instance.execute(<<-SQL, n: n)
    SELECT
      q.*
    FROM
      questions q
    JOIN
      likes ON q.id = likes.question_liked
    GROUP BY
      q.id
    ORDER BY
      COUNT(likes.question_liked) DESC
    LIMIT
      :n
    SQL

    options.map { |question| Question.new(question) }
  end
end