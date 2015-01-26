class TicketsController < ApplicationController
  # GET /players/tickets?player_id=[PLAYER_ID]&api_token=[API_TOKEN]
  # Get all tickets sold, any week
  def show_all_tickets
    tickets = Ticket.all
    render json: {count: tickets.count, tickets:tickets}, except: [:created_at, :updated_at]
  end

  # GET /players/tickets/:week_number?player_id=[PLAYER_ID]&api_token=[API_TOKEN]
  # Get tickets for all players for a specific week
  def show_all_tickets_by_week
    tickets = Ticket.where(week_number: params[:week_number])
    render json: {count: tickets.count, tickets:tickets}, except: [:created_at, :updated_at]
  end

  # GET /players/:search_id/tickets?player_id=[PLAYER_ID]&api_token=[API_TOKEN]
  # Get all tickets for a player
  def show_player_tickets
    player = Player.find_by(id: params[:search_id])
    render json: {count: player.tickets.count, tickets: player.tickets}, except: [:created_at, :updated_at]
  end

  # GET /players/:search_id/tickets/:week_number?player_id=[PLAYER_ID]&api_token=[API_TOKEN]
  # Get all tickets for a player for a specific week
  def show_player_tickets_by_week
    tickets = Ticket.where("player_id = ? and week_number = ?", params[:search_id], params[:week_number])
    render json: {count: tickets.count, tickets: tickets}, except: [:created_at, :updated_at]
  end


  # POST /tickets/new
  def create
    ticket = Ticket.new(ticket_params)
    if ticket.save
      drawing = Drawing.find_by(week_number: ticket.week_number)
      if drawing.nil?
        drawing = Drawing.new(week_number: ticket.week_number)
        drawing.save!
      end
      render json: ticket.render_json
    else
      render json: ticket.errors, status: :unprocessable_entity
    end
  end

  private
    def ticket_params
      params.permit(:player_id, :week_number)
    end

end
