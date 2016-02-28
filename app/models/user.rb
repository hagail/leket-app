# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  priority_id :string
#  email       :string
#  name        :string
#  phone       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class User < ActiveRecord::Base
  include SessionStorable

  has_many :pickups

  validates :email, uniqueness: true, presence: true
end
