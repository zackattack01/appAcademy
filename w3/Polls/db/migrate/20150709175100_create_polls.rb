class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.integer :user_id
      t.timestamps null: false
    end

    add_foreign_key :polls, :users, column: :user_id
  end
end
