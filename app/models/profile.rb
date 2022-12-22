class Profile < ApplicationRecord 
  belongs_to :user
  delegate :email, to: :user
  before_create :generate_avatar_seed, unless: :avatar_seed

  acts_as_follower

  def generate_avatar_seed
    self.avatar_seed = rand(27_546_624)
  end

end
