class DeleteCostFromTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :number_of_tickets
    remove_column :tickets, :total_cost
  end
end
