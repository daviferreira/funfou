Funfou::Application.routes.draw do

	root :to => "pages#home"

	match "/sobre", 				:to => "pages#about"
	match "/ajuda", 				:to => "pages#help"
	match "/fale-conosco",	:to	=> "pages#contact"

end
