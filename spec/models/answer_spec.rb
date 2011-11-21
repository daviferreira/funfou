# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Answer do
    before(:each) do
        @question = Factory(:question) 
        @attr = {
            :content => "Content",
            :score => 0,
            :published => true,
            :question_id => @question.id
        }
    end

    it "should create a new answer given valid attributes" do
        answer = Answer.create(@attr)
        answer.user_id = 1 #user_id is not accessible
        answer.should be_valid
        lambda do
            answer.save!.should be_true
        end.should change(Answer, :count).by(1) 
    end

  it "should require a content" do
    no_content_answer = Answer.new(@attr.merge(:content => ""))
    no_content_answer.user_id = 1
    no_content_answer.should_not be_valid
  end

  it "should require an user" do
    answer_without_user = Answer.new(@attr)
    answer_without_user.should_not be_valid
  end

  it "should require a question" do
      answer_without_question = Answer.new(@attr.merge({:question_id => ''}))
      answer_without_question.should_not be_valid
  end

end

# == Schema Information
#
# Table name: answers
#
#  id          :integer         not null, primary key
#  content     :text
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  score       :integer
#  published   :boolean
#

