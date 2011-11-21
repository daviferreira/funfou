# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20110323211306
#
# Table name: categories
#
#  id          :integer         not null, primary key
#  name        :text
#  created_at  :datetime
#  updated_at  :datetime
#  cached_slug :string(255)
#

class Category < ActiveRecord::Base
  attr_accessible :name
	is_sluggable :name

  has_many :tags, :dependent => :destroy
  has_many :questions, :through => :tags

  validates :name, :presence => true,
                   :uniqueness => true

  default_scope :order => 'categories.name ASC'
end
