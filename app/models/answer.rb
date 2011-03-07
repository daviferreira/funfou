class Answer < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	has_many :votes, :dependent => :destroy 
	
	validates :content, :presence => true
	validates :question_id, :presence => true
	validates :user_id, :presence => true
	
	default_scope :order => 'answers.created_at DESC'
end
