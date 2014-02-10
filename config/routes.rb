HoowenwareDev::Application.routes.draw do
  root "pages#index"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :trips do    
    member do
      get 'cancel'
      get 'reactivate'
    end
  end
  resources :users, only: [:show, :edit, :update]
end
