Rails.application.routes.draw do
  resources :items, defaults: { format: :json } do
    post :add_event, on: :member
    get :search, on: :collection
  end

  post '/login', to: 'users#login', defaults: { format: :json }
  get '/users/current', to: 'users#current', defaults: { format: :json }

  match '/*path' => 'application#cors_preflight_check', via: :options
end
