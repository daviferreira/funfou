class AnswersController < ApplicationController
	before_filter :authenticate

	def create
<<<<<<< HEAD
		id = params[:answer][:question_id]
		content = params[:answer][:content]
		@question = Question.find(id)
		if content.blank?
      flash[:error] = "Informe uma resposta."
	  else
	    flash[:success] = "Sua resposta foi publicada."
		  current_user.answer!(@question, content)
	  end
    redirect_to @question
	end

	def destroy

	end
=======
	end

  def destroy
  end
>>>>>>> 77059577bf768c30d7a85d1a4371d233844f48d8

end
