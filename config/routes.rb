Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
	root to: 'pages#home'

	namespace :api do
		# I don't want users to be listed/created/deleted through the API
		resources :users, only: [:update]
		resources :auth, only: [:create, :destroy]
		resources :people, only: [:index, :show, :create, :update, :destroy] do
			resources :addresses, only: [:index, :show, :create, :update, :destroy]
			resources :emails, only: [:index, :show, :create, :update, :destroy]
			resources :phone_numbers, only: [:index, :show, :create, :update, :destroy]
		end
	end

	resources :people do
		resources :addresses, only: [:new, :edit, :create, :update, :destroy]
		resources :emails, only: [:new, :edit, :create, :update, :destroy]
		resources :phone_numbers, only: [:new, :edit, :create, :update, :destroy]
	end

	resources :users, only: [:new, :create, :edit, :update, :destroy]

	get '/app', to: 'people#index'
	get '/account', to: 'users#edit'
	get '/about', to: 'pages#about'
	get '/signup', to: 'users#new'
	get '/login', to: 'auth#new'
	post '/login', to: 'auth#create'
	get '/logout', to: 'auth#destroy'
end
