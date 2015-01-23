Rails.application.routes.draw do
  get 'ticket/create'

  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get '/players/tickets' => 'tickets#index'
  get "/players/:search_id/tickets" => 'tickets#show'
  resources :players, only: [:create]
  
  post '/tickets/new' => 'tickets#create'

end
