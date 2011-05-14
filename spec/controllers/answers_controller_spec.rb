require 'spec_helper'

describe AnswersController do

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
        @question = Factory(:question, :user => @user)
      end

      it "should be successful" do
        lambda do
          post :create, {:answer => {:question_id => 1, :content => "foobar"}}
        end.should change(Answer, :count).by(1)
      end

    end

  end
 
  describe "POST 'update'" do
    
    describe "as a non-signed-in user" do
      it "should deny access" do
        put :update, {:id => 1}
        response.should redirect_to(login_path)
      end
    end

    describe "as an non-admin user" do

      it "should protect the page" do
        @user = Factory(:user)
        @question = Factory(:question, :user => @user)
        @answer = Factory(:answer, :user => @user, :question => @question)
        test_sign_in(@user)
        put :update, :id => @answer
        response.should redirect_to(root_path)
      end

    end

    describe "as an admin user" do
      before(:each) do 
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      it "should update the answer" do
        @user = Factory(:user)
        @question = Factory(:question, :user => @user)
        @answer = Factory(:answer, :user => @user, :question => @question)
        put :update, {:id => @answer, :answer => {:content => "updated"}}
        @answer.reload
        @answer.content == "updated"
      end
    end

  end

  describe "DELETE 'destroy'" do
    
    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, {:id => 1}
        response.should redirect_to(login_path)
      end
    end
    
    describe "as a non-admin user" do

      before(:each) do
        @user = Factory(:user)
        @question = Factory(:question, :user => @user)
        @answer = Factory(:answer, :user => @user, :question => @question)
      end

      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @answer
        response.should redirect_to(root_path)
      end

      it "should not destroy the answer" do
        test_sign_in(@user)
        lambda do
          delete :destroy, :id => @answer 
        end.should_not change(Answer, :count)
      end

    end

    describe "as an admin user" do
      before(:each) do 
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end
      
      it "should destroy answer" do
        @user = Factory(:user)
        @question = Factory(:question, :user => @user)
        @answer = Factory(:answer, :user => @user, :question => @question)
        lambda do
          delete :destroy, :id => @answer 
        end.should change(Answer, :count).by(-1)
      end
    end
    
  end

end
