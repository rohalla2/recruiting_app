class Player < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def render_json
    json = self.as_json({
      #:include => { :todos => { :only => :id } },
      :only => [:id, :email, :api_token]
    })
   # json['todos'] = json['todos'].map { |todo| todo['id'] }
    json.to_json
  end
end
