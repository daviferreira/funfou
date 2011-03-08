class PagesController < ApplicationController
  def home
		@title = "Página inicial"
		if signed_in?
			@questions = Question.all.paginate(:page => params[:page])
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
