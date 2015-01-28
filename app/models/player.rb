class Player < ActiveRecord::Base
  has_secure_password
  has_many :tickets

  validates :email, uniqueness: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def render_json
    json = self.as_json({
      :only => [:id, :email, :api_token]
    })
    json['winnings'] = {}
    json['winnings']['total'] = self.drawings_won.sum(:payout)
    json['winnings']['drawings_won'] = self.drawings_won.as_json(except: [:created_at, :updated_at])
    json.to_json
  end

  def render_json_public
    json = self.as_json({
      :except => [:api_token, :updated_at, :created_at, :password_digest]
    })
    json['winnings'] = {}
    json['winnings']['total'] = self.drawings_won.sum(:payout)
    json['winnings']['drawings_won'] = self.drawings_won.as_json(except: [:created_at, :updated_at])
    json.to_json
  end

  def drawings_won
    drawings = Drawing.where(winner_id: self.id)
  end
end
