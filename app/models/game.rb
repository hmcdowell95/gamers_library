class Game < ApplicationRecord
    belongs_to :system
    has_many :user_games
    has_many :users, through: :user_games
    validates :name, presence: true
    validates :rating, presence: true

    def self.search(s)
        if s
          self.where("name LIKE ?", "%#{s}%")
        else
          @games = Game.all
        end
    end
    
end
