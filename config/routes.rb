Funfou::Application.routes.draw do
  get "answers/create"

  get "answers/destroy"

  get "answer/create"

  get "answer/destroy"

	resources :users, :only => [:create, :update, :destroy]
	resources :sessions, :only => [:create, :destroy]
	resources :questions, :only => [:create, :destroy]
	resources :favorites, :only => [:create, :destroy]
	resources :answers, :only => [:create, :destroy]

	root :to => "pages#home"

	match "/perguntas",			:to => "questions#index", :as => :questions
	match "/perguntar",			:to => "questions#new", :as => :new_question
	match "/pergunta/:id",	:to => "questions#show", :as => :question 

	match "/sobre", 				:to => "pages#about"
	match "/ajuda", 				:to => "pages#help"
	match "/fale-conosco",	:to	=> "pages#contact", :as => :contact

	match "/usuario/:id",			:to => "users#show", :as => :user
	match "/usuarios",				:to => "users#index", :as => :users	
	match "/cadastro",      	:to => "users#new", :as => :new_user
	match "/meus-dados/:id",	:to	=> "users#edit", :as => :edit_user
	
	match "/login",         :to => "sessions#new", :as => :login
	match "/sair",          :to => "sessions#destroy", :as => :logout

end
