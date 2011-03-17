# == Schema Information
# Schema version: 20110308151603
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
#

class Answer < ActiveRecord::Base
  attr_accessible :content, :question_id, :score
  
	belongs_to :user
	belongs_to :question
	has_many :votes, :dependent => :destroy 
	
	validates :content, :presence => true
	validates :question_id, :presence => true
	validates :user_id, :presence => true
	
	default_scope :order => 'answers.score DESC, answers.created_at DESC'
	scope :published, :conditions => { :published => true }
end
