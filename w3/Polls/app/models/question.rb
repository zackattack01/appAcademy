class Question < ActiveRecord::Base
  validates :question_body, :poll_id, presence: true

  belongs_to(
    :poll,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: :Poll
  )

  has_many(
    :answer_choices,
    foreign_key: :question_id,
    primary_key: :id,
    class_name: :AnswerChoice
  )

  has_many(
    :responses, through: :answer_choices, source: :responses
  )

  def results
    choice_counts = Hash.new { 0 }
    # answer_choices.includes(:responses).each do |ac|
    #   choice_counts[ac.answer_choice] = ac.responses.length
    # end


    answer_choice_ids = self.answer_choices.to_a.map(&:id)
    count_hash = Question.find_by_sql([
                "SELECT
                  answer_choices.answer_choice, COUNT(responses.id)
                FROM
                  answer_choices
                LEFT OUTER JOIN
                  responses ON responses.answer_choice_id = answer_choices.id
                GROUP BY
                  answer_choices.id
                HAVING
                  answer_choices.id IN (#{answer_choice_ids.join(", ")});"
      ])
      count_hash.to_a
  end












end
