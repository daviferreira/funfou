class AnswersController < ApplicationController
	before_filter :authenticate

	def create
		id = params[:answer][:question_id]
		content = params[:answer][:content]
		@question = Question.find(id)
		if content.blank?
      flash[:error] = "Informe uma resposta."
	  else
		  current_user.answer!(@question, content)
	  end
    redirect_to @question
	end

	def destroy

	end

end
