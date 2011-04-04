Funfou::Application.routes.draw do

	resources :users, :only => [:create, :update, :destroy]
	resources :sessions, :only => [:create, :destroy]
	resources :questions, :only => [:create, :update, :destroy]
	resources :favorites, :only => [:create, :destroy]
	resources :answers, :only => [:create, :destroy, :update]
	resources :comments, :only => [:create, :destroy]
  resources :messages, :only => [:create]

	root :to => "pages#home"
 
  match "/perguntas/:order",      :to => "questions#index", :as => :perguntas_ordem	
	match "/perguntas",			        :to => "questions#index", :as => :perguntas
	match "/perguntar",			        :to => "questions#new", :as => :new_question
	match "/pesquisar",             :to => "questions#index", :as => :search
	match "/pergunta/:id/editar",   :to => "questions#edit", :as => :editar_pergunta
	match "/pergunta/:id",	        :to => "questions#show", :as => :pergunta
	match "/publicar-pergunta/:id", :to	=> "questions#toggle_published", :as => :publicar_pergunta
	match "/publicar-resposta/:id", :to	=> "answers#toggle_published", :as => :publicar_resposta
	match "/resposta/:id/editar",   :to => "answers#edit", :as => :editar_resposta

  match "/feed",                  :to => "questions#feed", :as => :feed
  match "/pergunta/:id/feed",     :to => "questions#feed_answers", :as => :feed_answers
  match "/categoria/:id/feed",    :to => "categories#feed", :as => :feed_categories

	match "/sobre", 				:to => "pages#about", :as => :about
	match "/contato",	      :to	=> "pages#contact", :as => :contact

	match "/usuario/senha",		          :to => "users#new_password", :as => :new_password
	match "/instrucoes",                :to => "users#password_instructions", :as => :password_instructions
	match "/senha/:salt",			          :to => "users#reset_password", :as => :reset_password
	match "/usuario/nova_senha",        :to => "users#save_password", :as => :save_password
	match "/usuario/:id/delete_avatar", :to => "users#destroy_avatar", :as => :delete_user_avatar
	match "/usuario/:id",			          :to => "users#show", :as => :usuario
	match "/usuario/:id/perguntas",			:to => "users#questions", :as => :usuario_perguntas
	match "/usuario/:id/favoritos",     :to => "favorites#index", :as => :usuario_favoritos
	match "/usuarios",				          :to => "users#index"	
	match "/cadastro",      	          :to => "users#new", :as => :new_user
	match "/usuario/:id/editar",        :to	=> "users#edit", :as => :edit_user
	match "/meus-dados",                :to	=> "users#edit", :as => :meus_dados
	match "/meus-favoritos",            :to => "favorites#index", :as => :meus_favoritos

	match "/toggle-admin/:id",  :to	=> "users#toggle_admin", :as => :toggle_admin
	match "/toggle-active/:id", :to	=> "users#toggle_active", :as => :toggle_active
	
	match "/login",           :to => "sessions#new", :as => :login
	match "/sair",            :to => "sessions#destroy", :as => :logout
	
	match "/vote/up/:id",     :to => "votes#up", :as => :vote_up
	match "/vote/down/:id",   :to => "votes#down", :as => :vote_down
	
	match "/favoritar/:id",   :to => "favorites#new", :as => :new_favorite
	
	match "/categorias",			:to => "categories#index", :as => :categorias
	match "/categoria/:id",   :to => "categories#show", :as => :categoria

end
