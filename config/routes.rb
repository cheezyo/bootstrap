Rails.application.routes.draw do
  resources :test_groups do 
    collection do
      put :add_player_to_group
    end
  end
  resources :tests do 
    collection do 
      get :update_test_score
      get :all_tests
      get :toplist
    end
  end
  resources :coaches
  resources :players
  resources :user_players, only: [:create, :update,:destroy] 
  devise_for :users, :path_prefix => 'my'
  resources :users
  resources :pages do 
	collection do 
		get :index
  end
end
  root :to => 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
