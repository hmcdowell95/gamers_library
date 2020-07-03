class Game < ApplicationRecord
    belongs_to :system
    has_many :user_games
    has_many :users, through: :user_games
end
