HoowenwareDev::Application.routes.draw do
  root "pages#index"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :trips do    
    get :cancel
    get :reactivate
  end
end
