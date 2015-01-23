class Ticket < ActiveRecord::Base
  belongs_to :player
  before_save :validate_player
  before_save :calculate_total
  validates_presence_of :number_of_tickets, :week_number
  
  def calculate_total 
    self.price = 1.00
    self.total_cost = self.price * self.number_of_tickets
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
