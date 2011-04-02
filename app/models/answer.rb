# == Schema Information
# Schema version: 20110323211306
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

class Answer < ActiveRecord::Base
  attr_accessible :content, :question_id, :score
  
	belongs_to :user
	belongs_to :question
	has_many :votes, :dependent => :destroy 
	has_many :comments, :dependent => :destroy 
	
	validates :content, :presence => true
	validates :question_id, :presence => true
	validates :user_id, :presence => true
	
	default_scope :order => 'answers.score DESC, answers.created_at DESC'
	scope :published, :conditions => { :published => true }
	scope :not_published, :order => 'created_at DESC', :conditions => { :published => nil }
end
