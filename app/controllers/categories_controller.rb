class CategoriesController < ApplicationController

  def index
    @category = Category.find(params[:id])
    @title = @category.name
  end

end
