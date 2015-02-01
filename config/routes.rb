PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/pin', to: 'sessions#pin'
  post '/pin', to: 'sessions#pin'

  resources :posts, except: [:destroy] do
    member do
      post :vote
    end 

    #nested comments with nested votes
    resources :comments, only: [:create] do
      member do
        post :vote
      end
    end
  end 

  resources :categories, only: [:new, :create, :show]

  resources :users, only: [:show, :create, :edit, :update] do 
  end

  namespace :admin do
    resources :users, only: [:index]
    resources :categories, only: [:index]
  end
  post '/admin/users', to: 'admin/users#update'
  delete '/admin/categories', to: 'admin/categories#destroy'

end
