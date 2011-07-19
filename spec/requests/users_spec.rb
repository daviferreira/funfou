require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do

      it "should not make a new user" do
        lambda do
          visit new_user_path
          fill_in "Nome", :with => ""
          fill_in "E-mail", :with => ""
          fill_in "Senha", :with => ""
          fill_in "Confirme sua senha", :with => ""
          click_button "Vai!"
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end

    end

    describe "success" do
      
      it "should make a new user" do
        lambda do
          visit new_user_path
          fill_in "Nome", :with => "Example User"
          fill_in "E-mail", :with => "user@example.com"
          fill_in "Senha", :with => "foobar"
          fill_in "Confirme sua senha", :with => "foobar"
          click_button "Vai!"
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end

    end

  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        visit login_path
        fill_in "Seu e-mail", :with => ""
        fill_in "Sua senha", :with => ""
        click_button "Login"
        response.should have_selector("div.flash.error", :content => "inválidos")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit login_path
        fill_in "Seu e-mail", :with => user.email
        fill_in "Sua senha", :with => user.password
        click_button "Login"
        controller.should be_signed_in
        click_link "Sair"
        controller.should_not be_signed_in
      end
    end

  end

  describe "password recovery" do

    describe "failure" do
      it "should not send instructions by email" do
        visit new_password_path
        fill_in "Digite seu e-mail", :with => ""
        click_button "Solicitar instruções"
        response.should have_selector("div.flash.error", :content => "não foi encontrado")
      end
    end

    describe "success" do
      it "should send instructions by email" do
        user = Factory(:user)
        visit new_password_path
        fill_in "Digite seu e-mail", :with => user.email
        click_button "Solicitar instruções"
        response.should have_selector("div.flash.success", :content => "instruções")
      end
    end

  end

end
