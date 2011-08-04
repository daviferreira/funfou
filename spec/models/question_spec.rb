# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Question do

  before(:each) do
    @attr = {
      :title => "Title",
      :content => "Content"
    }
    @user = Factory(:user)
  end

  it "should create a new question given valid attributes" do
    @user.questions.create!(@attr)
  end

  it "should require a title" do
    no_title_question = @user.questions.new(@attr.merge(:title => ""))
    no_title_question.should_not be_valid
  end

  it "should require a content" do
    no_content_question = @user.questions.new(@attr.merge(:content => ""))
    no_content_question.should_not be_valid
  end

  it "should require an user" do
    question_without_user = Question.new(@attr)
    question_without_user.should_not be_valid
  end

  it "should reject titles that are too long" do
    long_title = "a" * 141
    long_title_question = @user.questions.new(@attr.merge(:title => long_title))
    long_title_question.should_not be_valid
  end

end

# == Schema Information
#
# Table name: questions
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  content     :text
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  published   :boolean
#  cached_slug :string(255)
#

