class Drawing < ActiveRecord::Base
  has_many :tickets, foreign_key: :week_number, primary_key: :week_number
  # belongs_to :player, as: :player_chosen
  validates :week_number, uniqueness: true

end
