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
  
  has_many :questions, :through => :tags
end
