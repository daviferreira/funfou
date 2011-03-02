class PagesController < ApplicationController
  def home
		if signed_in?
			redirect_to '/perguntas'
		else
			@title = "Página inicial"
		end
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
