class AddSessionKeyToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :api_token, :string
  end
end
