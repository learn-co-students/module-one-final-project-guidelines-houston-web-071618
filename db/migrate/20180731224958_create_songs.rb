class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :musix_match_track_id
      t.string :lyrics
    end

  end
end
