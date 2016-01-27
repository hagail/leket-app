class User < ActiveRecord::Base
  include SessionStorable

  has_many :pickups

  validates :email, uniqueness: true, presence: true
end
