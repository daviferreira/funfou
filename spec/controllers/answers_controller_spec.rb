require 'spec_helper'

describe AnswersController do

  describe "GET 'create'" do
    
    describe "as a non-signed-in user" do
      it "should deny access" do
        get 'create'
        response.should redirect_to(login_path)
      end
    end
    
  end
  
  describe "DELETE 'destroy'" do
    
    describe "as a non-signed-in user" do
      it "should deny access" do
        get 'create'
        response.should redirect_to(login_path)
      end
    end
    
    describe "as a non-admin user" do
      it "should protect the page" do
        @user = Factory(:user)
        @question = Factory(:question, :user => @user)
        @answer = Factory(:answer, :user => @user, :question => @question)
        test_sign_in(@user)
        delete :destroy, :id => @answer
        response.should redirect_to(root_path)
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