Rails.application.routes.draw do
  # get 'ticket/create'

  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get '/players/tickets' => 'tickets#show_all_tickets'
  get '/players/tickets/:week_number' => 'tickets#show_all_tickets_by_week'
  get '/players/:search_id/tickets' => 'tickets#show_player_tickets'
  get '/players/:search_id/tickets/:week_number' => 'tickets#show_player_tickets_by_week'
  get '/players/:id/patches' => 'patches#show'

  get '/drawings' => 'drawings#index'
  post '/drawings/new' => 'drawings#new'
  get '/drawings/:week_number/players' => 'drawings#show'
  post '/drawings/:week_number/select' => 'drawings#select_winner'
  post '/drawings/:week_number/score' => 'drawings#record_results'

  get '/patches' => 'patches#index'
  post '/patches/new' => 'patches#create'


  resources :players, only: [:create, :show]
  
  post '/tickets/new' => 'tickets#create'

end