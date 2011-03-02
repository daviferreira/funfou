class QuestionsController < ApplicationController
   before_filter :authenticate, :only => [:new, :create, :destroy]

	def index
		@title = "Perguntas"
		@questions = Question.all.paginate(:page => params[:page])
	end

  def show
		@question = Question.find(params[:id])
		@title = @question.title
		@user = User.find(@question.user_id)
  end
 
	def new
		@title = "Fazer uma pergunta"
		@question = Question.new if signed_in?
	end

  def create
		@question = current_user.questions.build(params[:question])
		if @question.save
			flash[:success] = "Pergunta adicionada com sucesso"
			redirect_to @question
		else
			render 'questions/new'
		end
  end

  def destroy
  end
end
