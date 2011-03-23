class PagesController < ApplicationController
  def home
		@title = "Página inicial"
		@questions = Question.all
		if signed_in?
			if current_user.admin?
		    @questions = Question.all.paginate(:page => params[:page])
	    else
		    @questions = Question.published.paginate(:page => params[:page])
	    end
			@crumbs = [{"label" => "Perguntas", "path"   => perguntas_path, "last" => true, "active" => true}]
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
