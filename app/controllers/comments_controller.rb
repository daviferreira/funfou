class CommentsController < ApplicationController
  
  def create

    @question = Question.find_using_slug(params[:comment][:question_id])
    content = params[:comment][:content]
    if content.nil? or content.blank? or content == "Deixe um comentário."
      @error = "Cadê o comentário!?"
    else
		  @comment = current_user.comment!(params[:comment])
	  end
		respond_to do |format|
			format.html { redirect_to @question }
			format.js
		end

  end

end
