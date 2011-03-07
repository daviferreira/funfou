class SessionsController < ApplicationController

  def new
    @title = "Log in"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      if params[:session][:question_id]
        question = Question.find_by_id(params[:session][:question_id])
        session[:return_to] = question
      end
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
