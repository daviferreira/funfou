Funfou::Application.routes.draw do

  get "categories/index"

	resources :users, :only => [:create, :update, :destroy]
	resources :sessions, :only => [:create, :destroy]
	resources :questions, :only => [:create, :destroy]
	resources :favorites, :only => [:create, :destroy]
	resources :answers, :only => [:create, :destroy]

	resources :users do
	  member do
	    get :questions
    end
  end

	root :to => "pages#home"
  
	match "/perguntas",			:to => "questions#index", :as => :perguntas
	match "/perguntar",			:to => "questions#new", :as => :new_question
	match "/pesquisar",     :to => "questions#index", :as => :search
	match "/pergunta/:id",	:to => "questions#show", :as => :question
	
	match "/sobre", 				:to => "pages#about", :as => :about
	match "/ajuda", 				:to => "pages#help", :as => :help
	match "/fale-conosco",	:to	=> "pages#contact", :as => :contact

	match "/usuario/:id",			:to => "users#show", :as => :user
	match "/usuarios",				:to => "users#index"	
	match "/cadastro",      	:to => "users#new", :as => :new_user
	match "/meus-dados/:id",  :to	=> "users#edit", :as => :meus_dados
	match "/toggle-admin/:id",  :to	=> "users#toggle_admin", :as => :toggle_admin

	match "/favoritos",       :to => "favorites#index"
	
	match "/login",           :to => "sessions#new", :as => :login
	match "/sair",            :to => "sessions#destroy", :as => :logout
	
	match "/vote/up/:id",     :to => "votes#up", :as => :vote_up
	match "/vote/down/:id",   :to => "votes#down", :as => :vote_down
	
	match "/favoritar/:id",   :to => "favorites#new", :as => :new_favorite
	
	match "/categoria/:id",   :to => "categories#index", :as => :category
end
