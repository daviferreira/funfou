class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if signed_in?
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    
    if authentication
      sign_in authentication.user
      flash[:notice] = "Signed in successfully."
      redirect_back_or usuario_path(authentication.user)
    elsif signed_in?
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    elsif omniauth['provider'] == "facebook" || omniauth['provider'] == "google_apps"
      if omniauth['provider'] == "facebook"
        data = omniauth['extra']['user_hash']
      else
        data = omniauth['user_info']
      end
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
      redirect_to authentications_url
    else
      user = User.new
      user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      if user.save
        sign_in user
        flash[:notice] = "Signed in successfully."
        redirect_back_or usuario_path(user)
      else
        #render :text => omniauth.to_yaml
        session[:omniauth] = omniauth.except('extra')
        redirect_to completar_path
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
end
