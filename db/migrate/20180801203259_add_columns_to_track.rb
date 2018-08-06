class AddColumnsToTrack < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :country_name, :string
  end
end
