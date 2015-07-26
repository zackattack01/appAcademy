class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|
      t.references :sub, index: true, foreign_key: true, null: false
      t.references :post, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    remove_column :posts, :sub_id
  end
end
