class Reply
  include Saveable

  def self.all_replies
    replies = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      *
    FROM
      replies
    SQL
    replies.map { |reply| Reply.new(reply) }
  end

  attr_accessor :id,
    :subject_id,
    :parent_id,
    :reply_body,
    :reply_author_id

  def initialize(options = {})
    @id = options['id']
    @subject_id = options['subject_id']
    @parent_id = options['parent_id']
    @reply_body = options['reply_body']
    @reply_author_id = options['reply_author_id']
  end

  def author
    User.find_by_id(@reply_author_id)
  end

  def question
    Question.find_by_id(@subject_id)
  end

  def parent_reply
    return nil unless @parent_id
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    options = QuestionsDatabase.instance.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_id = :id
    SQL
    options.map { |reply| Reply.new(reply) }
  end

  def self.find_by_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = :id
    LIMIT
      1
    SQL

    Reply.new(options.first)
  end

  def self.find_by_question_id(subject_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, subject_id: subject_id)
    SELECT
      *
    FROM
      replies
    WHERE
      subject_id = :subject_id
    SQL

    options.map { |reply| Reply.new(reply) }
  end

  def self.find_by_user_id(reply_author_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, reply_author_id: reply_author_id)
    SELECT
      *
    FROM
      replies
    WHERE
      reply_author_id = :reply_author_id
    SQL

    options.map { |reply| Reply.new(reply) }
  end
end