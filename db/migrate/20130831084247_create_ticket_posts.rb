class CreateTicketPosts < ActiveRecord::Migration
  def change
    create_table :ticket_posts do |t|
      t.references :ticket
      t.references :user
      t.text :content

      t.timestamps
    end
  end
end
