class CreateDrawings < ActiveRecord::Migration
  def change
    create_table :drawings do |t|
      t.integer :week_number
      t.references :player_chosen, index: true
      t.integer :player_score
      t.boolean :strike
      t.float :payout

      t.timestamps null: false
    end
    add_foreign_key :drawings, :player_chosens
  end
end
