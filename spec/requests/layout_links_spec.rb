require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Funfou.com.br - Perguntas e respostas sobre PHP, Ruby on Rails, Python, Java, HTML, CSS, jQuery, ASP, .net")
  end

  it "should have a Contact page at '/contato'" do
    get '/contato'
    response.should have_selector('title', :content => "Fale conosco")
  end

  it "should have an About page at '/sobre'" do
    get '/sobre'
    response.should have_selector('title', :content => "Sobre o Funfou")
  end

  it "should have a Signup page at '/cadastro'" do
    get '/cadastro'
    response.should have_selector('title', :content => "Cadastre-se")
  end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href => login_path,
                                         :content => "Login")
    end

    it "should have a password recovery link" do
      visit login_path
      response.should have_selector("a", :href => new_password_path,
                                         :content => "Esqueceu sua senha?")
    end
  end

  describe "when signed in" do
  
    before(:each) do
      @user = Factory(:user)
      visit login_path
      fill_in "Seu e-mail", :with => @user.email
      fill_in "Sua senha", :with => @user.password
      click_button "Login"
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => logout_path,
                                         :content => "Sair")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => usuario_path(@user),
                                         :content => @user.name.split.first)
    end

  end
  
end
