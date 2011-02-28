class PagesController < ApplicationController
  def home
		@title = "Página inicial"
	end

  def contact
		@title = "Fale conosco"
  end

  def help
		@title = "Ajuda"
  end

  def about
		@title = "Sobre"
  end

end
