# == Schema Information
# Schema version: 20110308151603
#
# Table name: questions
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  attr_accessible :title, :content

	belongs_to :user
	has_many :visualizations, :dependent => :destroy
	has_many :favorites, :dependent => :destroy
	has_many :answers, :dependent => :destroy
	has_many :tags, :dependent => :destroy
	has_many :categories, :through => :tags

  validates :title, :presence => true, :length => { :maximum => 140 }
  validates :content, :presence => true
  validates :user_id, :presence => true
  
  default_scope :order => 'questions.created_at DESC'
end
