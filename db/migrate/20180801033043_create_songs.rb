class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :musix_match_track_id
      t.string :lyrics
      t.integer :artist_id
      t.integer :category_id
    end

  end
end
