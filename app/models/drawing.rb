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

  def record_results(winner_id, score, strike)
    if self.payout.nil?

      if self.winner_id == winner_id.to_i
        self.player_score = score
        self.strike = strike

        balance = calculate_current_balance

        if strike == 'true'
          self.payout = balance
          self.balance_forward = 0
        else
          self.payout = (balance * 0.1).round(2)
          self.balance_forward = (balance * 0.9).round(2)
        end
        self.save!
      else
        self.errors.add(:winner_id, "does not match")
      end
    end

  end

  private
    def calculate_current_balance
      if self.week_number > 1
        last_week = Drawing.find_by(week_number: self.week_number - 1)
      end

      this_week = self.tickets.sum(:price)

      if !last_week.nil?
        this_week + last_week
      else
        this_week
      end
    end

end