Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :sign_in, only: [:create] do
    delete :destroy, on: :collection
  end

  resources :transactions do
    collection do
      post 'deposit', to: 'transactions#deposit'
      post 'withdraw', to: 'transactions#withdraw'
      post 'transfer', to: 'transactions#transfer'
    end
  end

  resources :wallet do
    get :balance, on: :collection
  end

  resources :stock_prices do
    get :price_all, on: :collection
    get :prices, on: :collection
    get :price, on: :collection
  end
end
