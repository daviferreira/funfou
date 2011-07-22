# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe AuthenticationsController do
  render_views
 
  describe "GET create" do

    describe "for signed in users" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] = { "uid" => "12345" }
      end

      it "should authenticate" do
        get :create
        flash[:notice].should =~ /autenticada/i          
      end

      it "should redirect to the user edit path" do
        get :create      
        response.should redirect_to usuario_path @user
      end

    end
    
    
    describe "for non-signed in users" do

      describe "with e-mail" do
      
        before(:each) do
          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] = { "uid" => "12345", 
                                                                                 "user_info" => { 
                                                                                    "name" => "Foobar",
                                                                                    "email" => "teste@m2brnet.com" 
                                                                                  } 
                                                                                }
        end

        it "should create an user account" do
          get :create
          User.last.email.should == "teste@m2brnet.com"
        end

        it "should redirect to complete registration path" do
          get :create
          response.should redirect_to usuario_path(User.last)
        end
        
      end
      
      describe "without e-mail" do
      
      end

    end
    
  end   
   
  describe "GET 'failure'" do        

    it "should redirect to the signin path" do
      get :failure, :message => "Invalid credentials"
      flash[:error].should =~ /invalid/i   
      response.should redirect_to login_path 
    end
      
  end

  describe "DELETE 'destroy'" do

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => 1 
        response.should redirect_to(login_path)
      end
    end
    
    describe "as a signed-in user" do

    end
    
  end


end
