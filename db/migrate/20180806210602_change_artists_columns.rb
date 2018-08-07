class ChangeArtistsColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :artists, :wikipedia_bio_url, :string
  end
end
