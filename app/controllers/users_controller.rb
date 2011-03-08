class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  def index
    @title = "Usuários"
    @users = User.all.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions.paginate(:page => params[:page])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Cadastre-se"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Bem-vindo ao Funfou!"
      redirect_to @user
    else
      @title = "Cadastre-se"
      render 'new'
    end
  end
  
  def edit
    @title = "Meus dados"
  end
  
  def update
    @user = User.find(params[:id])
    
    vars = params[:user]
    if vars[:password].blank? && vars[:password_confirmation].blank?
      vars.delete('password')
      vars.delete('password_confirmation')
    end
    if @user.update_attributes(vars)
      flash[:success] = "Seus dados foram atualizados com sucesso."
      redirect_to @user
    else
      @title = "Meus dados"
      render 'edit'
    end
  end
  
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
end
