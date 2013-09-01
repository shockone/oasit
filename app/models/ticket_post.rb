class TicketPost < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user

  attr_accessible :content, :ticket_id, :user_id
end
