class UserSystem < ApplicationRecord
    belongs_to :user 
    belongs_to :system 
end