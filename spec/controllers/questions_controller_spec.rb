# -*- encoding : utf-8 -*-
require 'spec_helper'

describe QuestionsController do
  render_views
  
  describe "GET 'index'" do
    
  end
  
  describe "GET 'show'" do
    
  end
  
  describe "GET 'new'" do
    
  end

  describe "POST 'create'" do
    
    describe "as a non-signed-in user" do
      it "should deny access" do
        post :create
        response.should redirect_to(login_path)
      end
    end
    
    describe "as a signed-in user" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @attr = {:title => "Question title.", 
                 :content => "Question content.", 
                 :tags => ["php","ruby"]}
      end
      
      it "should be successful" do
        lambda do
          post :create, :question => @attr
        end.should change(Question, :count).by(1)
      end
      
      describe "success" do
        
        it "should be published" do
          post :create, :question => @attr
          Question.last.should be_published
        end
        
      end
      
    end
    
  end
  
  describe "POST 'update'" do
    
  end
  
  describe "DELETE 'destroy'" do

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => 1
        response.should redirect_to(login_path)
      end

      it "should not destroy the question" do
        lambda do
          delete :destroy, :id => 1
        end.should_not change(Question, :count)
      end
    end
    
    describe "as a non-admin user" do

      before(:each) do
        @user = Factory(:user)
        @question = Factory(:question, :user => @user)
      end

      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @question.id
        response.should redirect_to(root_path)
      end

      it "should not destroy the question" do
        test_sign_in(@user)
        lambda do
          delete :destroy, :id => @question.id
        end.should_not change(Question, :count)
      end

    end

    describe "as an admin user" do
      before(:each) do 
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end
      
      it "should destroy the question" do
        @user = Factory(:user)
        @question = Factory(:question, :user => @user)
        lambda do
          delete :destroy, :id => @question.id
        end.should change(Question, :count).by(-1)
      end
    end
    
    
  end
  
end
