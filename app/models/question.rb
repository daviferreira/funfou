class Question < ActiveRecord::Base
  attr_accessor :categories
  attr_accessible :title, :content

	belongs_to :user
	has_many :visualizations, :dependent => :destroy
	has_many :favorites, :dependent => :destroy
	has_many :answers, :dependent => :destroy

  validates :title, :presence => true, :length => { :maximum => 140 }
  validates :content, :presence => true
  validates :user_id, :presence => true
  
  default_scope :order => 'questions.created_at DESC'
end