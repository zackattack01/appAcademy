class CreateGoalComments < ActiveRecord::Migration
  def change
    create_table :goal_comments do |t|
      t.integer :author_id, null: false
      t.integer :goal_id, null: false
      t.string :body, null: false

      t.timestamps null: false
    end
  end
end
