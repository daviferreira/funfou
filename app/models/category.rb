# == Schema Information
# Schema version: 20110308151603
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :text
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  attr_accessible :name
	is_sluggable :name

  has_many :tags, :dependent => :destroy
  has_many :questions, :through => :tags

  default_scope :order => 'categories.name ASC'
end
