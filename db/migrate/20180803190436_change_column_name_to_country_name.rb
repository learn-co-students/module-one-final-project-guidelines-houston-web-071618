class ChangeColumnNameToCountryName < ActiveRecord::Migration[5.2]
  def change
    rename_column :countries, :name, :country_name
  end
end
