class Question < ActiveRecord::Base
  attr_accessible :title, :content
  belongs_to :user
  
  validates :title, :presence => true, :length => { :maximum => 140 }
  validates :content, :presence => true
  validates :user_id, :presence => true
  
  default_scope :order => 'questions.created_at DESC'
end
