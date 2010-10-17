SampleApp::Application.routes.draw do

  get "activations/create"

  resources :user_sessions, :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]
	resources :users do
    member do
      get :following, :followers
    end
  end

	resources :relationships, :only => [:create, :destroy]
	match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'user_sessions#new'
  match '/signout', :to => 'user_sessions#destroy'
  match '/contact', :to => 'pages#contact'
	match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/activate/:activation_code',    :to => 'activations#create'
	root :to => 'pages#home'
	
end
