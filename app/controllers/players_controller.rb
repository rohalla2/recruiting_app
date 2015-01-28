class PlayersController < ApplicationController
  skip_before_action :find_player_from_token, only: [:create]

  # GET /players/1
  def show
    render json: @player.render_json_public
  end

  # POST /players
  def create
    token = SecureRandom.hex
    player = Player.new(player_params)
    player.api_token = token
    player.email.downcase!

    if player.save
      render json: player.render_json
    else
      render json: player.errors, status: :unprocessable_entity
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
