# -*- encoding : utf-8 -*-
module SessionsHelper
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
    session[:last_login] = current_user.last_login
    current_user.update_attributes(:last_login => Time.now)
    self.current_user
  end
    
  def sign_out
    cookies.delete(:remember_token)
    session[:return_to] = nil
    self.current_user = nil
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end

	def invite_to_register?
		c = controller.controller_name
		if c == "users" or c == "sessions"
			false	
		else
		 	true	
		end
	end
  
  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end
  
  def authenticate
      c = params[:controller]
      a = params[:action]
      if c == "questions" and a == "new"
        session[:return_to] = new_question_path
      end
      deny_access unless signed_in?
    end

  def correct_user_or_admin
    id = params[:id] ? params[:id] : (signed_in? ? current_user.id : nil)
    @user = User.find_using_slug(id)
    redirect_to(root_path) unless current_user?(@user) or current_user.admin?
  end
    
  def admin_user
    @user = User.find_using_slug(params[:id])
    redirect_to(root_path) if !signed_in? or !current_user.admin? or current_user?(@user)
  end
  
  def deny_access
    store_location
    redirect_to login_path, :notice => "A página que você tentou acessar solicitou seu login."
  end
  
  def redirect_back_or(default)
    return_to = session[:return_to]
    clear_return_to
    redirect_to(return_to || default)
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end
end
