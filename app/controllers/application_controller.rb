class ApplicationController < ActionController::Base
  before_action :find_player_from_token

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected
    def find_player_from_token
      player = Player.find_by(api_token: params[:api_token])
      if player
        @player = player
      else
        render json: {message: 'Could not find that user!'}
      end 
    end

    def authorize
      unless Player.find_by(id: session[:player_id])
        redirect_to root_url, notice: "You need to log in to access this feature!"
      end
    end




end
