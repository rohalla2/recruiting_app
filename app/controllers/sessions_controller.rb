class SessionsController < ApplicationController
  skip_before_action :find_player_by_token, only: [:create]
  
  def create
    email = params[:email].downcase
    player = Player.find_by(email: email)

    if player && player.authenticate(params[:password])
      token = SecureRandom.hex
      player.api_token = token
      player.save!
      render json: {notice: 'Logged in!'}
    else
      render json: {error: 'Could not find that user!'}
    end


  end

  def destroy
    @player.api_token = nil
    @player.save!
    render json: {}
  end

end
