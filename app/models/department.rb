class Department < ActiveRecord::Base
  attr_accessible :title
  validates_uniqueness_of :title
end
