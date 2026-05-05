Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope '/auth' do
    post 'register', to: 'auth#register'
    post 'login',    to: 'auth#login'
    get  'me',       to: 'auth#me'
    get  'users',    to: 'auth#index'
  end

  resources :projects

  resources :uploads, only: %i[index create destroy] do
    member do
      get :download
    end
    collection do
      delete "by_item/:item_id", action: :destroy_by_item
    end
  end
  
  resources :concessionaires do 
    get "paginate", on: :collection
  end

  resources :customers do 
    get "paginate", on: :collection
  end

  resources :addresses do
    get "paginate", on: :collection
  end

  resources :services do
    get "paginate", on: :collection
  end
  
  get "up" => "rails/health#show", as: :rails_health_check

end
