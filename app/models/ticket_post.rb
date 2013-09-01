class TicketPost < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user

  attr_accessible :content
end
