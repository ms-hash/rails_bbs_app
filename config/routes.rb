Rails.application.routes.draw do
  resources :categories
  resources :blogs do 
    resources :comments
    collection do
      get 'search'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
