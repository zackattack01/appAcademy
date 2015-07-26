class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :answer_choice_id
      t.timestamps null: false
    end

    add_foreign_key :responses, :users, column: :user_id
    add_foreign_key :responses, :answer_choices, column: :answer_choice_id
  end
end
