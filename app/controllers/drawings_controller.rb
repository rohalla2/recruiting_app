class DrawingsController < ApplicationController


  # GET /drawings/:week_number/players?player_id=[PLAYER_ID]&api_token=[API_TOKEN]
  def show
    drawing = Drawing.find_by(week_number: params[:week_number])
    tickets = drawing.tickets
    players = []
    tickets.each do |ticket|
      players.push ticket.player
    end
    render json: players, except: [:password_digest, :created_at, :updated_at, :api_token] 
  end
end