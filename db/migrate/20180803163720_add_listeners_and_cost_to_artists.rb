class AddListenersAndCostToArtists < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :listeners, :integer
    add_column :artists, :cost, :integer
  end
end
