class CreateUserSystems < ActiveRecord::Migration[6.0]
  def change
    create_table :user_systems do |t|
      t.integer :user_id
      t.integer :system_id
    end
  end
end
