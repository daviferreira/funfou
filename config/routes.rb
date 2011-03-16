Funfou::Application.routes.draw do

  get "categories/index"

	resources :users, :only => [:create, :update, :destroy]
	resources :sessions, :only => [:create, :destroy]
	resources :questions, :only => [:create, :update, :destroy]
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
	match "/pergunta/editar/:id", :to => "questions#edit", :as => :editar_pergunta
	match "/pergunta/:id",	:to => "questions#show", :as => :pergunta
	match "/publicar-pergunta/:id",  :to	=> "questions#toggle_published", :as => :publicar_pergunta
	match "/publicar-resposta/:id",  :to	=> "answers#toggle_published", :as => :publicar_resposta
	
	match "/sobre", 				:to => "pages#about", :as => :about
	match "/ajuda", 				:to => "pages#help", :as => :help
	match "/fale-conosco",	:to	=> "pages#contact", :as => :contact

	match "/usuario/senha",		:to => "users#new_password", :as => :esqueceu
	match "/instrucoes",      :to => "users#password_instructions", :as => :instrucoes

	match "/usuario/:id",			:to => "users#show", :as => :usuario
	match "/usuarios",				:to => "users#index"	
	match "/cadastro",      	:to => "users#new", :as => :new_user
	match "/meus-dados/:id",  :to	=> "users#edit", :as => :meus_dados


	match "/toggle-admin/:id",  :to	=> "users#toggle_admin", :as => :toggle_admin
	match "/toggle-active/:id",  :to	=> "users#toggle_active", :as => :toggle_active


	match "/favoritos",       :to => "favorites#index"
	
	match "/login",           :to => "sessions#new", :as => :login
	match "/sair",            :to => "sessions#destroy", :as => :logout
	
	match "/vote/up/:id",     :to => "votes#up", :as => :vote_up
	match "/vote/down/:id",   :to => "votes#down", :as => :vote_down
	
	match "/favoritar/:id",   :to => "favorites#new", :as => :new_favorite
	
	match "/categorias",			:to => "categories#index", :as => :categorias
	match "/categoria/:id",   :to => "categories#show", :as => :categoria
end
