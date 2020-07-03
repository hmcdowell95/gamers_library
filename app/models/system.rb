class System < ApplicationRecord
    has_many :games
    has_many :user_systems
    has_many :users, through: :user_systems
end
