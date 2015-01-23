Rails.application.routes.draw do
  get 'ticket/create'

  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get '/players/tickets' => 'tickets#index'
  get '/players/tickets/:week_number' => 'tickets#show'
  get "/players/:search_id/tickets" => 'tickets#show'
  get "/drawings/:week_number/players" => 'drawings#show'
  resources :players, only: [:create]
  
  post '/tickets/new' => 'tickets#create'

end
