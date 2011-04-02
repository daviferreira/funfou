# == Schema Information
# Schema version: 20110323211306
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

class Question < ActiveRecord::Base
	attr_accessor :tags
	attr_accessible :title, :content
	is_sluggable :title

	belongs_to :user
	has_many :visualizations, :dependent => :destroy
	has_many :favorites, :dependent => :destroy
	has_many :answers, :dependent => :destroy
	has_many :tags, :dependent => :destroy
	has_many :categories, :through => :tags
	has_many :comments, :dependent => :destroy 

  validates :title, :presence => true, :length => { :maximum => 140 }
  validates :content, :presence => true
  validates :user_id, :presence => true
	validates :tags, :presence => true
  
  default_scope :order => 'questions.created_at DESC'
  scope :published, :conditions => { :published => true }, :order => 'questions.created_at DESC'
  
end
