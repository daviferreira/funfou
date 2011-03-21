class AnswersController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy, :edit, :update]
	before_filter :admin_user, :only => [:destroy, :edit, :update]
	before_filter :is_published, :only => [:show]

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
		@answer = Answer.find(params[:id])
		@question = Question.find(@answer.question_id)
		flash[:success] = "Resposta excluída com sucesso"
		redirect_to pergunta_path(@question)
	end
	
	def toggle_published
    @answer = Answer.find(params[:id])
    @answer.toggle!(:published)
		@question = Question.find_by_id(@answer.question_id)
    redirect_to pergunta_path(@question)
  end

	private

		def is_published
			unless signed_in? and current_user.admin?
				answer = Answer.find_using_slug(params[:id])
				if answer.nil? or not answer.published?
					redirect_to root_path
				end
			end
			true
		end

end
