class UserGame < ApplicationRecord
    belongs_to :user 
    belongs_to :game 
    # when user last played the game?
end
