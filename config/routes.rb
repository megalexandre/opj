Rails.application.routes.draw do
  resources :projects
  
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
