Funfou::Application.routes.draw do
	resources :users, :only => [:show, :create, :update, :destroy]
	resources :sessions, :only => [:create, :destroy]
	resources :questions, :only => [:create, :destroy]
	resources :favorites, :only => [:create, :destroy]
	resources :answers, :only => [:create, :destroy]

	root :to => "pages#home"

	match "/perguntas",			  :to => "questions#index", :as => :questions
	match "/perguntar",			  :to => "questions#new", :as => :new_question
	match "/pergunta/:id",	  :to => "questions#show", :as => :question 

	match "/sobre", 				  :to => "pages#about", :as => :about
	match "/ajuda", 				  :to => "pages#help", :as => :help
	match "/fale-conosco",	  :to	=> "pages#contact", :as => :contact
	
	match "/cadastro",        :to => "users#new", :as => :new_user
	match "/meus-dados/:id",  :to	=> "users#edit", :as => :edit_user
	match "/favoritos",       :to => "favorites#index", :as => :favorites
	
	match "/login",           :to => "sessions#new", :as => :login
	match "/sair",            :to => "sessions#destroy", :as => :logout
end
