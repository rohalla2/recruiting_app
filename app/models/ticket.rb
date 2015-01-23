class Ticket < ActiveRecord::Base
  belongs_to :player
  belongs_to :drawing, foreign_key: :week_number, primary_key: :week_number

  before_save :validate_player
  before_save :add_price
  validates_presence_of :week_number, :player_id
  
  def add_price
    self.price = 1.00
  end

  def validate_player
    # Stub
    # do now allow ticket to be purchased if last week there was no winner
  end

  def render_json
    json = self.as_json({
      :except => [:created_at, :updated_at]
    })

    json.to_json
  end

end
