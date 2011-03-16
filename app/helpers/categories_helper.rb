module CategoriesHelper
	def total_questions(category)
		if signed_in? and current_user.admin?
			category.questions.count
		else
			category.questions.published.count
		end
	end
end
