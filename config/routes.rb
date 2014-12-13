Rails.application.routes.draw do
  resources :items, defaults: { format: :json }

  post '/login', to: 'users#login', defaults: { format: :json }
end
