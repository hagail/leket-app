class Supplier < ActiveRecord::Base
  has_many :suppliers
  belongs_to :supplier
end
