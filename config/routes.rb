Funfou::Application.routes.draw do
	resources :users, :only => [:show, :create, :update, :destroy, :toggle_admin, :edit]
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

	match "/perguntar",			  :to => "questions#new", :as => :new_question
	match "/pergunta/:id",	  :to => "questions#show", :as => :question 
	match "/perguntas",			  :to => "questions#index"
	match "/pesquisar",       :to => "questions#index", :as => :search

	match "/sobre", 				  :to => "pages#about", :as => :about
	match "/ajuda", 				  :to => "pages#help", :as => :help
	match "/fale-conosco",	  :to	=> "pages#contact", :as => :contact
	
	match "/usuarios",        :to => "users#index", :as => :users
	match "/cadastro",        :to => "users#new", :as => :new_user
	match "/meus-dados/:id",  :to	=> "users#edit", :as => :meus_dados
	match "/toggle-admin/:id",  :to	=> "users#toggle_admin", :as => :toggle_admin

	match "/favoritos",       :to => "favorites#index"
	
	match "/login",           :to => "sessions#new", :as => :login
	match "/sair",            :to => "sessions#destroy", :as => :logout
	
	match "/vote/up/:id",     :to => "votes#up", :as => :vote_up
	match "/vote/down/:id",   :to => "votes#down", :as => :vote_down
	
	match "/favoritar/:id",   :to => "favorites#new", :as => :new_favorite
end
