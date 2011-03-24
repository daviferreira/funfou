class FavoritesController < ApplicationController
	before_filter :authenticate

  def index
    if not params[:id].nil?
      user = User.find_using_slug(params[:id])
      id = user.id
    else 
      id = current_user.id ? current_user.id : nil
    end
    @favorites = Favorite.where("user_id = ?", id)
    unless @favorites.empty?
      params = ""
      @favorites.each do |f|
        params = params + f.question_id.to_s + ","
      end
      params = params + "-1"
      @favorites = Question.where("id IN (#{params})").paginate(:page => params[:page])
    end
  end

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
