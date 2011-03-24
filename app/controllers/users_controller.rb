class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user_or_admin, :only => [:edit, :update]
  before_filter :admin_user,	:only => [:destroy, :toggle_admin, :toggle_active]
  
  def index
    @title = "Usuários"
    @users = User.all.paginate(:page => params[:page])
  end

  def show
    @user = User.find_using_slug(params[:id])
    @questions = @user.questions.published.limit(5)
    @answers = @user.answers.published.limit(5)
    @title = @user.name
    @crumbs = default_crumb
    @crumbs.push({"label" => @user.name.downcase, "path" => usuario_path(@user)})
  end

  def new
    @user = User.new
    @title = "Cadastre-se"
		@crumbs = [{"label" => "cadastro", "path"   => new_user_path}]
	end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      @user.toggle!(:active)
			@user.generate_slug!
      sign_in @user
      flash[:success] = "Bem-vindo ao Funfou!"
      redirect_to usuario_path(@user)
    else
      @title = "Cadastre-se"
 			@crumbs = [{"label" => "cadastro", "path"   => new_user_path}]
 			render 'new'
		end
  end
  
  def edit
    @title = "Meus dados"
    @user = current_user
  end
  
  def destroy
    User.find_using_slug(params[:id]).destroy 
    flash[:success] = "User destroyed." 
    redirect_to users_path
  end

  def toggle_admin
    @user = User.find_using_slug(params[:id])
    @user.toggle!(:admin)
    if @user.admin?
      flash[:success] = "User toggled as admin." 
    else
      flash[:success] = "User is not an admin anymore."
    end
    redirect_to users_path
  end
  
  def toggle_active
    @user = User.find_using_slug(params[:id])
    @user.toggle!(:active)
    if @user.active?
      flash[:success] = "User activated." 
    else
      flash[:success] = "User de-acticated."
    end
    redirect_to users_path
  end
  
  def update
    @user = User.find_using_slug(params[:id])
   	 
    vars = params[:user]
    if vars[:password].blank? && vars[:password_confirmation].blank?
      vars.delete('password')
      vars.delete('password_confirmation')
    end
    if @user.update_attributes(vars)
			@user.generate_slug!
      flash[:success] = "Seus dados foram atualizados com sucesso."
      redirect_to usuario_path(@user)
    else
      @title = "Meus dados"
      render 'edit'
    end
  end
  
  def questions
    user = User.find_using_slug(params[:id])
    @questions = Question.published.where("user_id = ?", user.id).paginate(:page => params[:page])
  end

	def new_password
		@title = "Nova senha"
		@user = User.new
		@crumbs = [{"label" => "criar uma nova senha", "path"   => instrucoes_path}]
	end
	
	def password_instructions
	  email = params[:instructions][:email]
	  error = true
	  unless email.nil? or email.empty?
      user = User.find_by_email(email)
      unless user.nil? or !user.active
        UserMailer.password_instructions(user, request.host_with_port).deliver
	      flash[:success] = "As instruções foram enviadas para o e-mail #{email}."
        redirect_to esqueceu_path
        error = false
      end
    end
    if error
      flash[:error] = "Seu e-mail não foi encontrado em nossa base."
      redirect_to esqueceu_path
    end
  end

	def reset_password
		@user = User.find_by_salt(params[:salt])
		if @user.nil? or not @user.active?
			flash[:error] = "Usuário inválido."
			redirect_to root_path
		else
			@title = "Redefinir senha"
		end
	end

	def save_password
		password = params[:user][:password]
		confirmation = params[:user][:password_confirmation]
		error = nil
		if password.length < 6
			error = "Sua senha deve possuir no mínimo 6 caracteres."
		elsif password != confirmation
			error = "As senhas digitadas não conferem."
		end
		if error.nil?
			@user = User.find_by_salt(params[:user][:salt])
			if @user.update_attributes(:password => password)
				sign_in @user
				flash[:success] = "Sua senha foi redefinida com sucesso."
				redirect_to usuario_path(@user)
			else
				flash[:error] = "Erro ao salvar sua senha."
				redirect_to redefinir_senha_path(params[:user][:salt])
			end
		else
			flash[:error] = error
			redirect_to redefinir_senha_path(params[:user][:salt])
		end
	end

  private

    def correct_user
      @user = User.find_using_slug(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def correct_user_or_admin
      @user = User.find_using_slug(params[:id])
      redirect_to(root_path) unless current_user?(@user) or current_user.admin?
    end
    
    def default_crumb
      [{"label" => "usuários", "path" => usuarios_path}]
    end
    
end
