class Ticket < ActiveRecord::Base
  belongs_to :player
  belongs_to :drawing, foreign_key: :week_number, primary_key: :week_number

  validate :week_available
  before_save :add_price
  validates_presence_of :week_number, :player_id
  
  def add_price
    self.price = 1.00
  end

  def week_available
    if Drawing.exists?(week_number: self.week_number)
      d = Drawing.find_by(week_number: self.week_number)
      if !d.winner_id.nil?
        self.errors.add(:error, 'That week is not open for ticket buying!') # error: can't buy this ticket
      end
    else
        self.errors.add(:error, 'That week is not open for ticket buying!') # error: can't buy this ticket      
    end
  end

  def render_json
    json = self.as_json({
      :except => [:created_at, :updated_at]
    })

    json.to_json
  end

end
