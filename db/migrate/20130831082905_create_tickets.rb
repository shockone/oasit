class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :department
      t.references :ticket_status, index: true
      t.references :reporter, index: true
      t.references :employee, index: true
      t.string :subject

      t.timestamps
    end
  end
end
