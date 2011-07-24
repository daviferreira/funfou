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
        get :up, {:id => @answer}
        response.should redirect_to(login_path)
      end
      
      it "should not change answer score" do
        score = @answer.score
        get :up, {:id => @answer}
        @answer.score.should == score
      end
      
    end
    
    describe "for signed-in users" do
      before(:each) do
        test_sign_in(@user)
        @second_user = Factory(:user, :email => "teste@teste.com")
        @second_answer = Factory(:answer, :user => @second_user, :question => @question)
        @third_answer = Factory(:answer, :user => @second_user, :question => @question)
      end
      
      it "should not vote on user's own answer" do
        score = @answer.score
        get :up, {:id => @answer}
        @answer.reload
        @answer.score.should == score
      end
      
      it "should change other user's answers score by 1" do
        score = @second_answer.score
        get :up, {:id => @second_answer}
        @second_answer.reload
        @second_answer.score.should == 1
      end
      
      it "should remove user vote on another answer from same question" do
        get :up, {:id => @second_answer}
        get :up, {:id => @third_answer}
        @second_answer.reload
        @third_answer.reload
        @second_answer.score.should == 0
        @third_answer.score.should == 1
      end
      
    end

  end

end
