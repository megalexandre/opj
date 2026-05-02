Rails.application.routes.draw do
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
  
  get "up" => "rails/health#show", as: :rails_health_check

end
