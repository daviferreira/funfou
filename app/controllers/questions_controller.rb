class QuestionsController < ApplicationController
   before_filter :authenticate, :only => [:new, :create, :destroy, :edit, :update]
	 before_filter :admin_user, :only => [:destroy, :edit, :update]
	 before_filter :is_published, :only => [:show]

	def index
		@title = "Perguntas"
		if params[:keywords].nil?
		  if signed_in? and current_user.admin?
		    @questions = Question.all.paginate(:page => params[:page])
	    else
		    @questions = Question.published.paginate(:page => params[:page])
	    end
	  else
	    keywords = '%' + params[:keywords] + '%';
	    @questions = Question.published.where("title LIKE ? OR content LIKE ?", keywords, keywords).paginate(:page => params[:page])
		  if @questions.count == 1
		    redirect_to @questions.first
	    end
	  end
	end

  def show
		@question = Question.find(params[:id])
		add_visualization(@question.id)
		@title = @question.title
		@user = User.find(@question.user_id)
		@answers = @question.answers.published
		if signed_in?
		  @answer = Answer.new 
		  @answers = @question.answers if current_user.admin?
	  end
  end
 
	def new
		@title = "Fazer uma pergunta"
		if signed_in?
			@question = Question.new 
			@tags = ""
		end
	end

	def edit
		@title = "Editar pergunta"
		@question = Question.find_by_id(params[:id])
		@tags = tags_to_string(@question.tags) 
	end

  def create
		@question = current_user.questions.build(params[:question])
		if @question.save
		  @question.toggle!(:published)
			save_tags(@question.id, params[:question][:tags])
			flash[:success] = "Pergunta adicionada com sucesso"
			redirect_to pergunta_path(@question)
		else
			render 'questions/new'
		end
  end

	def update
		@question = Question.find(params[:id])
		if @question.update_attributes(params[:question])
			save_tags(@question.id, params[:question][:tags])
			flash[:success] = "Pergunta editada com sucesso"
			redirect_to editar_pergunta_path(@question) 
		else
			@title = "Editar pergunta"
			@tags = tags_to_string(@question.tags)
			render 'edit'
		end
	end

  def destroy
		Question.find(params[:id]).destroy
		flash[:success] = "Pergunta excluída com sucesso."
		redirect_to perguntas_path
  end
  
  def toggle_published
    @question = Question.find(params[:id])
    @question.toggle!(:published)
    redirect_to pergunta_path(@question)
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

		def tags_to_string(tags)
			tags_as_string = ""
			unless tags.empty? or tags.nil?
				tags.each do |tag|
					@category = Category.find_by_id(tag.category_id)
					tags_as_string += @category.name + ","
				end
			end
			tags_as_string.sub(/,$/, '')
		end

		def save_tags(question_id, tags)
			tags_to_delete = Tag.where("question_id = ?", question_id)
			unless tags_to_delete.empty?
				tags_to_delete.each do |tag|
					tag.destroy
				end
			end
		  tags = tags.split(",")
		  unless tags.empty?
		    tags.each do |tag|
		      @category = Category.find_by_name(tag)
		      if @category.nil?
		        @category = Category.create!(:name => tag)
	        end
	        Tag.create!(:question_id => question_id, :category_id => @category.id)
	      end
	    end
		end

    def is_published
      unless signed_in? and current_user.admin?
        question = Question.find_by_id(params[:id])
        if not question.published?
          redirect_to root_path
        end
      end
      true
    end

end
