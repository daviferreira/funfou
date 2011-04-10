class QuestionsController < ApplicationController
   before_filter :authenticate, :only => [:new, :create, :destroy, :edit, :update]
	 before_filter :admin_user, :only => [:destroy, :edit, :update]
	 before_filter :is_published, :only => [:show]

	def index
	  @per_page = 20
		@title = "Perguntas"
		@questions = index_with_order
		@questions = @questions.paginate(:page => params[:page], :per_page => @per_page)
		
		@crumbs = default_crumb

		if not params[:order].nil?
		  @crumbs.push({:label => params[:order].sub("_", " "),
		                :path => perguntas_ordem_path(params[:order])})
		elsif not params[:keywords].nil?
		  @crumbs.push({:label => "busca por " + params[:keywords],
		                :path => search_path + "?keywords=" + params[:keywords]})
	  end

    @categories = categories_for_sidebar
	  
	  respond_to do |format|
      format.html
      format.atom { render :action => "feed", :layout => false }
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end  
	end
	
	def feed
	  @questions = Question.published.order("created_at DESC").limit(20)
  end

  def show
		@question = Question.find_using_slug(params[:id])
		@comments = []
		@question.comments.each do |c|
		  @comments.push(c) if c.answer_id.nil?
	  end
		add_visualization(@question.id)
		@question.content = @question.content.gsub("<pre>", "<pre class=\"dom\">")
		@title = @question.title
		@user = User.find(@question.user_id)
		@answers = @question.answers.published
		if signed_in?
		  @answer = Answer.new 
		  @answers = @question.answers if current_user.admin?
	  end
		@crumbs = default_crumb
		@crumbs.push({:label => @question.title.downcase, :path => pergunta_path(@question)})
	  respond_to do |format|
      format.html
      format.atom { render :action => "feed_answers", :layout => false }
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end  
	end
	
	def feed_answers
	  @question = Question.find_using_slug(params[:id])
	  @answers = @question.answers.published
  end
 
	def new
		@title = "Fazer uma pergunta"
		if signed_in?
			@question = Question.new 
			@tags = "[]"
		end
		@crumbs = default_crumb
		@crumbs.push({:label => "enviar uma nova pergunta", :path => new_question_path})
	end

	def edit
		@title = "Editar pergunta"
		@question = Question.find_using_slug(params[:id])
		@tags = tags_to_json(@question.tags) 
	end

  def create
		@question = current_user.questions.build(params[:question])
		if @question.save
		  @question.generate_slug!
		  @question.toggle!(:published)
			save_tags(@question.id, params[:question][:tags])
			flash[:success] = "Pergunta adicionada com sucesso"
			redirect_to pergunta_path(@question)
		else
			@tags = params[:question][:tags].to_json		  
			@crumbs = default_crumb
  		@crumbs.push({:label => "enviar uma nova pergunta", :path => new_question_path})
			render 'questions/new'
		end
  end

	def update
		@question = Question.find_using_slug(params[:id])
		if @question.update_attributes(params[:question])
			save_tags(@question.id, params[:question][:tags])
			@question.generate_slug!
			flash[:success] = "Pergunta editada com sucesso."
			redirect_to pergunta_path(@question)
		else
			@title = "Editar pergunta"
			@tags = params[:question][:tags].to_json
			render 'edit'
		end
	end

  def destroy
		Question.find_using_slug(params[:id]).destroy
		flash[:success] = "Pergunta excluída com sucesso."
		redirect_to perguntas_path
  end
  
  def toggle_published
    @question = Question.find_using_slug(params[:id])
    @question.toggle!(:published)
    redirect_to pergunta_path(@question)
  end

	private
		
		def add_visualization(question_id)
			@client_ip = request.remote_ip
			@agent = request.env['HTTP_USER_AGENT'].downcase 
			if Visualization.where("question_id = ? AND ip_address = ?", 
														 question_id, @client_ip).blank? and not @agent.include?("facebook")
				Visualization.create(:question_id => question_id,
														 :ip_address => @client_ip,
														 :browser_agent => @agent)
			end
		end

		def tags_to_s(tags)
			tags_as_string = ""
			unless tags.empty? or tags.nil?
				tags.each do |tag|
					@category = Category.find_by_id(tag.category_id)
					tags_as_string += @category.name + ","
				end
			end
			tags_as_string.sub(/,$/, '')
		end

		def tags_to_json(tags)
			res = []
			unless tags.empty? or tags.nil?
				tags.each do |tag|
					@category = Category.find_by_id(tag.category_id)
					res.push(@category.name)
				end
			end
			res.to_json
		end


		def save_tags(question_id, tags)
			tags_to_delete = Tag.where("question_id = ?", question_id)
			unless tags_to_delete.empty?
				tags_to_delete.each do |tag|
					tag.destroy
				end
			end
		  unless tags.empty?
		    tags.each do |tag|
		      @category = Category.find_by_name(tag)
		      if @category.nil?		        
	          @category = Category.create!(:name => tag.strip)
					  @category.generate_slug!
	        end
	        Tag.create!(:question_id => question_id, :category_id => @category.id)
	      end
	    end
		end

    def is_published
      unless signed_in? and current_user.admin?
        question = Question.find_using_slug(params[:id])
        if question.nil? or not question.published? 
          redirect_to root_path
        end
      end
      true
    end

		def index_with_order
			keywords = nil
			if params[:keywords]
				keywords = '%' + params[:keywords] + '%'
			end

			if signed_in? and current_user.admin?
				if keywords.nil?
					questions = Question.all
				else
					questions = Question.where("title LIKE ? OR content LIKE ?", keywords, keywords)
				end
			else
				if keywords.nil?
					questions = Question.published
				else
					questions = Question.published.where("title LIKE ? OR content LIKE ?", keywords, keywords)
				end
			end

			if params[:order] == 'mais_acessadas'
				questions = questions.sort_by{|question| question.visualizations.count}.reverse
			elsif params[:order] == 'mais_respostas'
				questions = questions.sort_by{|question| question.answers.published.count}.reverse
			elsif params[:order] == 'mais_favoritos'
				questions = questions.sort_by{|question| question.favorites.count}.reverse
			elsif params[:order] == 'sem_respostas'
				tmp = []
				questions.each do |q|
					tmp.push(q) if q.answers.count == 0
				end	
				questions = tmp
			end

			questions

		end

    def default_crumb
      [{:label => "Perguntas", :path => perguntas_path}]
    end

end
