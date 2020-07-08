class AddLastPlayedToUserGames < ActiveRecord::Migration[6.0]
  def change
    add_column :user_games, :last_played, :string
  end
end
