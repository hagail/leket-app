class User < ActiveRecord::Base
  has_many :pickups

  validates :email, uniqueness: true, presence: true
end
