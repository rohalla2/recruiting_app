class ApplicationController < ActionController::Base
  before_action :find_player_from_token

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected
    def find_player_from_token
      player = Player.find_by(api_token: params[:api_token], id: params[:player_id])
      if player
        @player = player
      else
        render json: {message: 'Invalid Token or ID!'}
      end 
    end

end
