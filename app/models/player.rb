class Player < ActiveRecord::Base
  has_secure_password

def render_json
    json = self.as_json({
      #:include => { :todos => { :only => :id } },
      :only => [:id, :email, :api_token]
    })
   # json['todos'] = json['todos'].map { |todo| todo['id'] }
    json.to_json
  end
end
