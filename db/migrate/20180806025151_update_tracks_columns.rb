class UpdateTracksColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :tracks, :country_name, :string
    remove_column :tracks, :artist_mbid, :string
  end
end
