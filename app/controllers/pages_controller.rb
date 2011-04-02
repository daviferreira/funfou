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
			@crumbs = [{:label => "Perguntas", :path   => perguntas_path}]
		end

    @categories = categories_for_sidebar

	end

  def contact
		@title = "Fale conosco"
		@crumbs = [{:label => "contato", :path => contact_path}]
	end

  def about
		@title = "Sobre"
		@crumbs = [{:label => "sobre o funfou", :path => about_path}]
  end

end
