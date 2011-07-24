# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CommentsController do
  render_views

  describe "POST 'create'" do
    
    before(:each) do
      @user = Factory(:user)
      @question = Factory(:question, :user => @user)
      @answer = Factory(:answer, :question => @question, :user => @user)
      @question_comment = {:content => "question comment", :question_id => @question.id}
      @answer_comment = {:content => "answer comment", :answer_id => @answer.id, :question_id => @question.id}
    end
    
    describe "For non signed in users" do
      it "should protect the action" do
        post :create, {:comment => @question_comment}
        response.should redirect_to(login_path)
      end
    end
    
    describe "For signed in users" do
      before(:each) do
        test_sign_in(@user)
      end
      
      it "shoud not post an invalid comment" do
        lambda do
          post :create, {:comment => @question_comment.merge({:content => ""})}
        end.should_not change(Comment, :count)
      end
      
      it "should post a valid comment on a question" do
        lambda do
          post :create, {:comment => @question_comment}
        end.should change(Comment, :count).by(1)
      end
      
      it "should post a valid comment on an answer" do
        lambda do
          post :create, {:comment => @answer_comment}
        end.should change(Comment, :count).by(1)
      end
    end
    
  end
  
end
