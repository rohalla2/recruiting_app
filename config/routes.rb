Rails.application.routes.draw do
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :players, only: [:create]

end
