class DrawingsController < ApplicationController

  # GET /drawings
  def index
    json_arr = {}
    json_arr['total_payout'] = Drawing.all.sum(:payout)
    
    d = Drawing.last
    balance = 0
    if d.balance_forward.nil? # if this week is still open
      balance = d.tickets.sum(:price)
      
      if Drawing.count != 1
        # balance is last foward + current ticket sales
        balance += Drawing.where(week_number: d.week_number - 1).first.balance_forward
      end
    else # this week closed
      # balance is last forward
      balance = d.balance_forward
    end
    json_arr['balance'] = balance
    json_arr['drawings'] = Drawing.all.as_json(except: [:created_at, :updated_at])

    # Current Balance
    render json: json_arr
  end

  # POST /drawings/new
  def new
    # week Number
    d = Drawing.find_by(week_number: params[:week_number])

    if d.nil?
      prev = Drawing.last
      if Drawing.count == 0 || (prev.week_number == params[:week_number].to_i - 1 && !prev.balance_forward.nil?)
        #create
        draw = Drawing.create(week_number: params[:week_number])

        render json: draw.render_json

      else
        render json: {error: 'This Drawing cannot be created yet!'}
      end
    else
      render json: {error: 'Drawing already exists for this week!'}
    end

  end

  # GET /drawings/:week_number/players?player_id=[PLAYER_ID]&api_token=[API_TOKEN]
  # Get all players who are in the drawing
  def show
    player_ids = Ticket.where(week_number: params[:week_number]).uniq.pluck(:player_id)
    players = Player.find(player_ids)
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