class System < ApplicationRecord
    has_many :games
    has_many :user_systems
    has_many :users, through: :user_systems
    validates :name, presence: true
    validates :name, uniqueness: true
    validates :company, presence: true 
end
