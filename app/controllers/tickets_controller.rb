class TicketsController < ApplicationController
  # GET /players/tickets?player_id=[PLAYER_ID]&api_token=[API_TOKEN]
  def index
    tickets = Ticket.all
    render json: tickets, except: [:created_at, :updated_at]
  end

  # GET /players/tickets?player_id=[PLAYER_ID]&api_token=[API_TOKEN]
  def show
    tickets = Ticket.where(week_number: params[:week_number])
    render json: tickets, except: [:created_at, :updated_at]
  end

  # POST /tickets/new
  def create
    ticket = Ticket.new(ticket_params)
    if ticket.save
      render json: ticket.render_json
    else
      render json: ticket.errors, status: :unprocessable_entity
    end
  end

  # GET /players/#{search_id}/tickets?player_id=[PLAYER_ID]&api_token=[API_TOKEN]
  def show
    player = Player.find_by(id: params[:search_id])
    render json: player.tickets, except: [:created_at, :updated_at]
  end

  private
    def ticket_params
      params.permit(:player_id, :week_number, :number_of_tickets)
    end

end
