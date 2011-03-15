class CategoriesController < ApplicationController

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
