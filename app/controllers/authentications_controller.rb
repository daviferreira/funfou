# -*- encoding : utf-8 -*-
class AuthenticationsController < ApplicationController
  before_filter :authenticate, :only => [:destroy]
  before_filter :correct_user_or_admin, :only => [:destroy]

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], "#{omniauth['uid']}")
    if authentication
      sign_in authentication.user
      flash[:notice] = "Login efetuado com sucesso."
      redirect_back_or usuario_path(authentication.user)
    elsif signed_in?
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Sua conta foi autenticada com sucesso."
      redirect_to usuario_path(current_user)
    elsif omniauth['user_info']['email']
      data = omniauth['user_info']
      url = ""
      unless omniauth["user_info"]["urls"].nil?
        url = omniauth["user_info"]["urls"]["Website"]
      end
      if user = User.find_by_email(data["email"])
        sign_in user
      else
        pass = (0...8).map{65.+(rand(25)).chr}.join
        user = User.create!(:name => data["name"], :email => data["email"], 
                     :password => pass, :site => url ) 
        user.toggle!(:active)
        sign_in user
      end
      user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      redirect_to usuario_path(user)
    else
      user = User.new
      user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      session[:omniauth] = omniauth.except('extra')
      redirect_to completar_path
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to usuario_path(current_user), :notice => "Autenticação removida com sucesso."
  end

  def failure
    flash[:error] = params[:message]
    redirect_to login_path 
  end
  
  private
  
    def correct_user_or_admin
      @authentication = Authentication.find(params[:id])
      @user = User.find(@authentication.user_id)
      redirect_to(root_path) unless current_user?(@user) or current_user.admin?
    end
  
end
