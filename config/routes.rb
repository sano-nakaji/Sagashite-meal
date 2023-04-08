Rails.application.routes.draw do
  get 'search', to: "search#search"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'shops', to: "search#shops"
  get 'shops/:id', to: 'shop#show', as: 'shop'
  
  # Defines the root path route ("/")
  # root "articles#index"
end
