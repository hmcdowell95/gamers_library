class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :rating
      t.string :description
      t.integer :user_id
      t.integer :system_id

      t.timestamps
    end
  end
end
