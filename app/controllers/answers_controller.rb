class AnswersController < ApplicationController
	before_filter :authenticate

	def create
		id = params[:answer][:question_id]
		content = params[:answer][:content]
		@question = Question.find(id)
		if content.blank?
      flash[:error] = "Informe uma resposta."
	  else
	    flash[:success] = "Sua resposta foi publicada."
		  current_user.answer!(@question, content)
	  end
    redirect_to pergunta_path(@question)
	end

	def destroy

	end
	
	def toggle_published
    @answer = Answer.find(params[:id])
    @answer.toggle!(:published)
    redirect_to pergunta_path(@answer.question_id)
  end

end
