class Department < ActiveRecord::Base
  has_many :tickets

  attr_accessible :title
  validates_uniqueness_of :title
end
