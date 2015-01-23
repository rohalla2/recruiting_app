Rails.application.routes.draw do
  # get 'ticket/create'

  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get '/players/tickets' => 'tickets#show_all_tickets'
  get '/players/tickets/:week_number' => 'tickets#show_all_tickets_by_week'
  get '/players/:search_id/tickets' => 'tickets#show_player_tickets'
  get '/players/:search_id/tickets/:week_number' => 'tickets#show_player_tickets_by_week'

  get '/drawings/:week_number/players' => 'drawings#show'
  resources :players, only: [:create]
  
  post '/tickets/new' => 'tickets#create'

end