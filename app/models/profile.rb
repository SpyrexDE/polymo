class Profile < ApplicationRecord
    belongs_to :user
    delegate :email, :to => :user
end
