class CreateHighScore < ActiveRecord::Migration[5.0]
  def change
    create_table :high_scores do |t|
      t.integer :high_score
    end
  end
end
