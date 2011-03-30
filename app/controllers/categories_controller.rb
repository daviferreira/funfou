class CategoriesController < ApplicationController

	def index
		all_categories = Category.all
		@categories = []
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
    @title = @category.name
    if signed_in? and current_user.admin?
      @questions = @category.questions
    else
      @questions = @category.questions.published
    end
    @crumbs = default_crumb
    @crumbs.push({:label => @category.name, :path => categoria_path(@category)})
  end

  private
    
    def default_crumb
      [{:label => "categorias", :path => categorias_path}]
    end

end
