class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question_body
      t.integer :poll_id
      t.timestamps null: false
    end

    add_foreign_key :questions, :polls, column: :poll_id
  end
end
