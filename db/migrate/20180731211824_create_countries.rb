class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :top_artist_mbid
    end 
  end
end
