class AddColumnsToArtist < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :low_estimated_cost, :integer
    add_column :artists, :high_estimated_cost, :integer
    add_column :artists, :wikipedia_bio_url, :string
    add_column :artists, :wikipedia_bio_intro, :string
    add_column :artists, :actual_known_cost?, :boolean
    add_column :artists, :image_url, :string
  end
end
