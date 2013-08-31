class Ticket < ActiveRecord::Base
  has_one :user
  has_one :ticket_status
  has_many :ticket_posts



  # attr_accessible :title, :body
end
