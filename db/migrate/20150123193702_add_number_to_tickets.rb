class AddNumberToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :number_of_tickets, :integer
    add_column :tickets, :total_cost, :float
  end
end
