class Drawing < ActiveRecord::Base
  has_many :tickets, foreign_key: :week_number, primary_key: :week_number
  validates :week_number, uniqueness: true

  def select_winner
    if self.winner_id.nil?
      offset = rand(self.tickets.count)
      winning_ticket = self.tickets.offset(offset).first
      self.winner_id = winning_ticket.player.id
      self.save!
    end
  end

  def winner
    player = Player.find(self.winner_id)
  end


end