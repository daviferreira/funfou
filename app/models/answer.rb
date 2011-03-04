class Answer < ActiveRecord::Base
	attr_accessible :content
	belongs_to :user
	belongs_to :question
	has_many :votes, :dependent => :destroy 

	validates :content, :presence => true
end
