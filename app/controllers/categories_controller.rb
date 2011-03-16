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
	end

  def show
    @category = Category.find(params[:id])
    @title = @category.name
    if signed_in? and current_user.admin?
      @questions = @category.questions
    else
      @questions = @category.questions.published
    end
  end

end
