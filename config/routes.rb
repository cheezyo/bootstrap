Rails.application.routes.draw do
  resources :type_of_exercises
  resources :exercise_types
  resources :exercises
  resources :matches
  resources :type_of_trainings
  resources :type_of_tranings
  resources :trainings
  resources :task_comments
  resources :tournaments do 
    collection do
      get :next_52_weeks
      put :add_player_to_tournament
      get :remove_player_from_tournament
    end
  end
  resources :planets

  resources :task_categories do 
    collection do 
      get :show_completed
    end
  end
  resources :tasks do 
    collection do
      get :add_progress
    end
  end
  resources :stickers
  resources :levels do 
  collection do 
     get :add_sticker
     get :delete_sticker
  end
end
  resources :training_programs
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
      get :avg
      get :save_year
    end
  end
  resources :coaches
  resources :players do 
  collection do 
    get :ironman_player
    get :add_sticker
    get :delete_sticker
    get :utr
  end
end
  resources :user_players, only: [:create, :update,:destroy] 
  devise_for :users, :path_prefix => 'my'
  resources :users 
  resources :pages do 
	collection do 
		get :index
    get :task_report
  end
end
  root :to => 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
