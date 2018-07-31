class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.string :name
      t.integer :playcount
      t.string :artist_mbid
    end 
  end
end
