class AddPremiumColumnToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :premium, :default => :false
    end

    User.all.each do |user|
      user.premium = false
      user.save!
    end
  end
end
