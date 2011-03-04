class QuestionsController < ApplicationController
   before_filter :authenticate, :only => [:new, :create, :destroy]

	def index
		@title = "Perguntas"
		@questions = Question.all.paginate(:page => params[:page])
	end

  def show
		@question = Question.find(params[:id])
		add_visualization(@question.id)
		@title = @question.title
		@user = User.find(@question.user_id)
		@answer = Answer.new if signed_in?
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

	private
		
		def add_visualization(question_id)
			@client_ip = request.remote_ip
			if Visualization.where("question_id = ? AND ip_address = ?", 
														 question_id, @client_ip).blank?
				@agent = request.env['HTTP_USER_AGENT'].downcase 
				Visualization.create(:question_id => question_id,
														 :ip_address => @client_ip,
														 :browser_agent => @agent)
			end
		end
end
