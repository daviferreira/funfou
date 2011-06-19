# -*- encoding : utf-8 -*-
class PagesController < ApplicationController
  def home
		@questions = Question.all
		if signed_in?
			if current_user.admin?
		    @questions = Question.all.paginate(:page => params[:page])
	    else
		    @questions = Question.published.paginate(:page => params[:page])
	    end
			@crumbs = [{:label => "Perguntas", :path   => perguntas_path}]
		else
		  @questions = Question.published.limit(5)
		  @answers = Answer.published.limit(5)
		  @users = User.order("created_at DESC").shuffle
		  @aux = []
		  unless @users.empty?
		    @users.each do |user|
		      if user.avatar.exists?
		        @aux.push(user)
	        end
	      end
  	    @users = @aux.slice!(0,9)
	    end
		end

    @categories = categories_for_sidebar

	end

  def contact
		@title = "Fale conosco"
		@crumbs = [{:label => "contato", :path => contact_path}]
    @message = Message.new
	end

  def about
		@title = "Sobre o Funfou"
		@crumbs = [{:label => "sobre o funfou", :path => about_path}]
  end

end
