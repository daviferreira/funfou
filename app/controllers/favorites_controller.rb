class FavoritesController < ApplicationController
	before_filter :authenticate

	def create
		id = params[:favorite][:question_id]
		if current_user.favorites.find_by_question_id(id).nil?
			@question = Question.find(id)
			if @question.user_id != current_user.id
				current_user.favorite!(@question)
				respond_to do |format|
					format.html { redirect_to @question }
					format.js
				end
			end
		end
	end

	def destroy
		@question = Favorite.find(params[:id]).question
		current_user.unfavorite!(@question)
		respond_to do |format|
			format.html { redirect_to @question }
			format.js
		end
	end

end
