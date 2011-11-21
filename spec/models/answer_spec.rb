# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Answer do
    before(:each) do
        @user = Factory(:user)
        @question = {
            :title => "Title",
            :content => "Content"
        }
        @attr = {
            :content => "Content",
            :score => 0,
            :published => true
        }
    end

    it "should create a new answer given valid attributes" do
        lambda do
            question = @user.questions.new(@question).save!
            @user.answers.create!(@attr.merge({:question_id => question.id}))
        end.should change(Answer, :count).by 1
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

