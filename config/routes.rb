HoowenwareDev::Application.routes.draw do
  root "pages#index"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :trips do    
    member do
      get 'cancel'
      get 'reactivate'
    end
    resources :polls
  end

  resources :groups do
    member do
      get 'deactivate'
      get 'reactivate'
    end

    resources :memberships, only: [:new, :create]
    
    get "memberships/:email/approve" => 'memberships#approve', 
        :controller => 'memberships',
        :constraints => { :email => /[^\/]+/},
        :as => 'approve_membership'

    get "memberships/:email/pend" => 'memberships#pend', 
        :controller => 'memberships',
        :constraints => { :email => /[^\/]+/ },
        :as => 'pend_membership'

    get "memberships/:email/promote" => 'memberships#promote', 
        :controller => 'memberships',
        :constraints => { :email => /[^\/]+/ },
        :as => 'promote_membership'

    get "memberships/:email/demote" => 'memberships#demote', 
        :controller => 'memberships',
        :constraints => { :email => /[^\/]+/ },
        :as => 'demote_membership'

    delete "memberships/:email/remove" => 'memberships#remove', 
        :controller => 'memberships',
        :constraints => { :email => /[^\/]+/ },
        :as => 'remove_membership'
  end
  
  resources :users, only: [:show, :edit, :update]
end
