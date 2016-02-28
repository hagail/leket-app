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

require 'rails_helper'

describe User do
  it { should validate_uniqueness_of(:email) }
end
