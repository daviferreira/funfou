# -*- encoding : utf-8 -*-
require 'spec_helper'

describe VotesController do
  render_views

  describe "GET 'up'" do

    before(:each) do
      @user = Factory(:user)
      @question = Factory(:question, :user => @user)
      @answer = Factory(:answer, :user => @user, :question => @question)
    end

    describe "for non-signed in users" do
      
      it "should protect the page" do
        get :up, {:id => @question.id, :answer_id => @answer.id}
        response.should redirect_to(login_path)
      end
      
      it "should not change answer score" do
        score = @answer.score
        get :up, {:id => @question.id, :answer_id => @answer.id}
        @answer.score.should == score
      end
      
    end
    
    describe "for signed-in users" do
      before(:each) do
        test_sign_in(@user)
      end
      
      it "should not vote on user's own answer" do
        score = @answer.score
        get :up, {:id => @question.id, :answer_id => @answer.id}
        @answer.reload
        @answer.score.should == score
      end
      
      it "should change other user's answers score by 1" do
        
      end
      
      it "should remove user vote on another answer from same question" do
        
      end
      
      it "should not allow more than one vote by question" do
        
      end
      
    end

  end

end
