class CreateRelatedArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :related_artists do |t|
      t.integer :related_artist_id
      t.integer :match_amount
    end
  end
end
