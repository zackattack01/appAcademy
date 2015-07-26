class User
  include Saveable

  def self.all_users
    users = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      *
    FROM
      users
    SQL
    
    users.map { |user| User.new(user) }
  end

  attr_accessor :id, :fname, :lname

  def initialize(options = {})
    raise "invalid parameters" unless options['fname'] && options['lname']
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      users
    WHERE
      id = :id
    LIMIT 
      1
    SQL

    User.new(options.first)
  end

  def self.find_by_name(fname, lname)
    options = QuestionsDatabase.instance.execute(<<-SQL, fname: fname, lname: lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = :fname AND lname = :lname
    LIMIT
      1
    SQL

    User.new(options.first)
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    Follow.followed_questions_for_user_id(id)
  end

  def liked_questions
    Like.liked_questions_for_user_id(id)
  end

  def average_karma
    num = QuestionsDatabase.instance.execute(<<-SQL, id: id)
    SELECT
      CAST(COUNT(l.id) AS FLOAT) / COUNT(DISTINCT(q.id)) AS karma 
    FROM
      questions q
    LEFT OUTER JOIN
      likes l ON l.question_liked = q.id
    WHERE
      q.author_id = :id
    SQL

    num.first['karma']
  end
end