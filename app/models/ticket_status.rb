class TicketStatus < ActiveRecord::Base
  belongs_to :ticket
  # attr_accessible :title, :body
end
