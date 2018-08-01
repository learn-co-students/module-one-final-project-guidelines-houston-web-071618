class UpdateTrackColumnToListeners < ActiveRecord::Migration[5.2]
  def change
    rename_column :tracks, :playcount, :listeners
  end
end
