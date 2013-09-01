class Ticket < ActiveRecord::Base
  belongs_to :reporter, :class_name => 'User'
  belongs_to :assignee, :class_name => 'User'
  belongs_to :ticket_status
  belongs_to :department
  has_many :ticket_posts, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :department, :ticket_posts

  attr_accessible :subject, :department_id, :ticket_posts_attributes, :reporter_id, :ticket_status_id, :employee_id

  def to_param
    "#{Department.find(department_id).title.upcase}-#{id}"
  end
end
