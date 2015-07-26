class RemoveBooleanColumns < ActiveRecord::Migration
  def change
  	remove_column :albums, :live
  	remove_column :tracks, :bonus
  	add_column :albums, :rec_type, :string, default: "studio"
  	add_column :tracks, :track_type, :string, default: "regular"

  end
end
