class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.text :answer_choice
      t.integer :question_id
      t.timestamps null: false
    end

    add_foreign_key :answer_choices, :questions, column: :question_id
  end
end
