class Ticket < ActiveRecord::Base
  belongs_to :reporter, :class_name => 'User'
  belongs_to :assignee, :class_name => 'User'
  has_one :ticket_status
  has_one :department
  has_many :ticket_posts, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :department, :ticket_posts, :reporter

  attr_accessible :subject, :department_id, :ticket_posts_attributes, :reporter_attributes
end
