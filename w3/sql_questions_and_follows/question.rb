class Question
  include Saveable

  def self.all_questions
    questions = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      *
    FROM
      questions
    SQL
    questions.map { |question| Question.new(question) }
  end

  attr_accessor :id, :title, :body, :author_id

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    User.find_by_id(author_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def self.find_by_author_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      questions
    WHERE
      author_id = :id
    SQL

    options.map { |question| Question.new(question) }
  end

  def self.find_by_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = :id
    LIMIT
      1
    SQL

    Question.new(options.first)
  end

  def followers
    Follow.followers_for_question_id(id)
  end

  def self.most_followed(n)
    Follow.most_followed_questions(n)
  end

  def num_likes
    Like.num_likes_for_question_id(id)
  end

  def likers
    Like.likers_for_question_id(id)
  end

  def self.most_liked(n)
    Like.most_liked_questions(n)
  end
end