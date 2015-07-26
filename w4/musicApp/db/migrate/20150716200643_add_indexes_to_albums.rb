class AddIndexesToAlbums < ActiveRecord::Migration
  def change
  	add_index :albums, :band_id
  	add_index :tracks, :album_id, unique: true
  end
end
