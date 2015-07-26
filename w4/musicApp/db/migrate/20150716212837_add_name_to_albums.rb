class AddNameToAlbums < ActiveRecord::Migration
  def change
  	add_column :albums, :title, :string, default: "Untitled"
  	add_column :tracks, :title, :string, default: "Untitled"
  end
end
