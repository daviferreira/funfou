# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20110402151912
#
# Table name: comments
#
#  id          :integer         not null, primary key
#  content     :text
#  user_id     :integer
#  question_id :integer
#  answer_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Comment < ActiveRecord::Base
  attr_accessible :content, :question_id, :answer_id
  
  belongs_to :user
  belongs_to :question
  belongs_to :answer
  
  validates :content, :presence => true
  validates :answer_id, :presence => true, :if => :should_validate_answer?
	validates :question_id, :presence => true, :if => :should_validate_question?
	validates :user_id, :presence => true
	
	default_scope :order => 'comments.created_at ASC'
	
  def should_validate_answer?
    question_id.blank?
  end
  
  def should_validate_question?
    answer_id.blank?
  end
  
end
