class DrawingsController < ApplicationController


  # GET /drawings/:week_number/players?player_id=[PLAYER_ID]&api_token=[API_TOKEN]
  # Get all players who are in the drawing
  def show
    drawing = Drawing.find_by(week_number: params[:week_number])
    tickets = drawing.tickets
    players = []
    tickets.each do |ticket|
      players.push ticket.player
    end
    render json: {count: players.count, players: players}, except: [:password_digest, :created_at, :updated_at, :api_token] 
  end

  def select_winner
    drawing = Drawing.find_by(week_number: params[:week_number])
    drawing.select_winner
    render json: {winner: drawing}, except: [:password_digest, :created_at, :updated_at]
  end

  # capture results of player's throw
  def record_results
    drawing = Drawing.find_by(week_number: params[:week_number])
    drawing.record_results(params['winner_id'], params['player_score'], params['strike'].downcase)
    render json: {winner: drawing}, except: [:password_digest, :created_at, :updated_at]
  end
end