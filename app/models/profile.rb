class Profile < ApplicationRecord 
  belongs_to :user
  delegate :email, to: :user
  before_create :generate_avatar_seed, unless: :avatar_seed

  def generate_avatar_seed
    self.avatar_seed = rand(9999)
  end

end
