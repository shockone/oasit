class TicketStatus < ActiveRecord::Base
  has_many :ticket
  attr_accessible :name

  def self.default_status_id
    TicketStatus.where(name: 'Waiting for Staff Response').first.id || 1
  end
end
