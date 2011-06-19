# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
	def categories_for_sidebar
	  all_categories = Category.all
		@categories = []
		unless all_categories.empty?
			all_categories.each do |category|
				questions = category.questions.published
			  @categories.push(category) if not questions.empty?
			end
		end
    @categories.shuffle.slice(0,30)
  end
  
end
