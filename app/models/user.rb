class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true
end
