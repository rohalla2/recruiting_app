class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.float :price
      t.integer :week_number
      t.references :player, index: true

      t.timestamps null: false
    end
    add_foreign_key :tickets, :players
  end
end
