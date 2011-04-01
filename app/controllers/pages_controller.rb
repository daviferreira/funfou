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

    all_categories = Category.all
		@categories = []
		unless all_categories.empty?
			all_categories.each do |category|
				questions = category.questions.published
			  @categories.push(category) if not questions.empty?
			end
		end
    @categories = @categories.shuffle.slice(0,30)

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
