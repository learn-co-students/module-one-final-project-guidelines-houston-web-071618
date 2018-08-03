class AddArtistNameToCountry < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :artist_name, :string
    add_column :countries, :listeners, :integer
  end
end
