Rails.application.routes.draw do
  resources :items, defaults: { format: :json } do
    post :add_event, on: :member
  end

  post '/login', to: 'users#login', defaults: { format: :json }
end
