class FavoritesController < ApplicationController
	before_filter :authenticate

	def create
		@question = Question.find(params[:favorite][:question_id])
		current_user.favorite!(@question)
		redirect_to @question
	end

	def destroy
		@question = Favorite.find(params[:id]).question
		current_user.unfavorite!(@question)
		redirect_to @question
	end
end
