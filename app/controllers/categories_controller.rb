# -*- encoding : utf-8 -*-
class CategoriesController < ApplicationController

	def index
		all_categories = Category.all
		@categories = []
		@title = "Todas as categorias - Perguntas e respostas sobre PHP, Ruby on Rails, Python, Java, HTML, CSS, jQuery, ASP, .net."
		unless all_categories.empty?
			all_categories.each do |category|
				if signed_in? and current_user.admin?
					questions = category.questions
				else
					questions = category.questions.published
				end
				if not questions.empty?
					@categories.push(category)
				end
			end
		end
    @crumbs = default_crumb 
  end

  def show
    @category = Category.find_using_slug(params[:id])
    @title = "Perguntas e respostas sobre #{@category.name} - Funfou"
    @meta_description = "Aqui você encontra perguntas e respostas de programadores #{@category.name}. Tire todas as suas dúvidas em #{@category.name}!";
    if signed_in? and current_user.admin?
      @questions = @category.questions
    else
      @questions = @category.questions.published
    end
    @crumbs = default_crumb
    @crumbs.push({:label => @category.name, :path => categoria_path(@category)})

    respond_to do |format|
      format.html
      format.atom { render :action => "feed", :layout => false }
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end  
	end

	def feed
	  @category = Category.find_using_slug(params[:id])
	  @questions = @category.questions.published
  end

  private
    
    def default_crumb
      [{:label => "categorias", :path => categorias_path}]
    end

end
