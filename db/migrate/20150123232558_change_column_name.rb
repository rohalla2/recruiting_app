class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :drawings, :player_chosen_id, :winner_id
  end
end
