class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :department
      t.references :ticket_status, index: true
      t.references :user, index: true
      t.string :title

      t.timestamps
    end
  end
end
