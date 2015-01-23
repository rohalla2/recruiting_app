class PlayersController < ApplicationController
  skip_before_action :find_player_from_token, only: [:create]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
    # render json of player email
  end

  # POST /players
  # POST /players.json
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
