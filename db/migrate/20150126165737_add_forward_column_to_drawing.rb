class AddForwardColumnToDrawing < ActiveRecord::Migration
  def change
    add_column :drawings, :balance_forward, :float
  end
end
