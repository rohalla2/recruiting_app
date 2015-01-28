class CreatePatches < ActiveRecord::Migration
  def change
    create_table :patches do |t|
      t.string :name
      t.references :player, index: true

      t.timestamps null: false
    end
    add_foreign_key :patches, :players
  end
end
