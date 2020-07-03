class User < ApplicationRecord
    has_many :user_systems
    has_many :user_games
    has_many :systems, through: :user_systems
    has_many :games, through: :user_games
end
