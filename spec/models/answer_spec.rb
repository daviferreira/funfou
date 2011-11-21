# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Answer do
    before(:each) do
        @question = Factory(:question) 
        @attr = {
            :content => "Content",
            :score => 0,
            :published => true,
            :user_id => @question.user.id,
            :question_id => @question.id
        }
    end

    it "should create a new answer given valid attributes" do
        answer = Answer.create(@attr)
        answer.user_id = @attr[:user_id]
        answer.should be_valid
        answer.save!.should be_true
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

