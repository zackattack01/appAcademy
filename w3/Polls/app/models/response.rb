class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cant_respond_to_their_own_poll
  #scope :sibling_responses -> { remove_self_from_list }
  belongs_to(
    :answer_choice,
    foreign_key: :answer_choice_id,
    primary_key: :id,
    class_name: :AnswerChoice
  )

  belongs_to(
    :respondent,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User
  )

  has_one(
    :question, through: :answer_choice, source: :question
  )

  # has_many :association_name,
  #   -> { where(color: 'red') },
  #   class_name, foreign_key,
  #   primary_key

  scope :red, -> { where(color: 'red') }

  def sibling_responses
    self.question.responses.where("? IS NULL OR responses.id != ?", id, id)
  end

  # def self.red
  #   Response.where(color: 'red')
  # end

private

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: self.user_id)
      errors[:response] << "Respondent has already answered this question"
    end
  end

  def author_cant_respond_to_their_own_poll
    if answer_choice.question.poll.user_id == user_id
      errors[:response] << "Author can't respond to their own poll"
    end
  end

end
