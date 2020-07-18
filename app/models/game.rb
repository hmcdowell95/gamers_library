class Game < ApplicationRecord
    belongs_to :system
    has_many :user_games
    has_many :users, through: :user_games
    validates :name, presence: true
    validates :rating, presence: true
    scope :search, ->(s) {where("name LIKE ?", "%#{s}%")}
    
end
