Funfou::Application.routes.draw do
	resources :users
	resources :sessions, :only => [:new, :create, :destroy]
	resources :questions, :only => [:show, :new, :create, :destroy]

	root :to => "pages#home"

	match "/perguntas",			:to => "questions#index"

	match "/sobre", 				:to => "pages#about"
	match "/ajuda", 				:to => "pages#help"
	match "/fale-conosco",	:to	=> "pages#contact", :as => :contact
	
	match "/cadastro",      :to => "users#new"
	
	match "/login",         :to => "sessions#new"
	match "/sair",          :to => "sessions#destroy"

end
