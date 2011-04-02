class SessionsController < ApplicationController

  def new
    @title = "Log in"
		@crumbs = default_crumb
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Usuário e/ou senha inválidos."
      @title = "Log in"
      @crumbs = default_crumb
      render 'new'
    else
      sign_in user
      if params[:session][:question_id]
        question = Question.find_by_id(params[:session][:question_id])
        session[:return_to] = pergunta_path(question) + '#answer_form'
      end
      redirect_back_or usuario_path(user)
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
  private
  
    def default_crumb
      [{:label => "login", :path => login_path}]
    end
end
