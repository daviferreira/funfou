# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20110308151603
#
# Table name: votes
#
#  id         :integer         not null, primary key
#  answer_id  :integer
#  user_id    :integer
#  value      :integer
#  created_at :datetime
#  updated_at :datetime
#

class Vote < ActiveRecord::Base
	attr_accessible :value, :answer_id
	belongs_to :user
	belongs_to :question

  validates :user_id, :presence => true
  validates :answer_id, :presence => true
  validates :value, :presence => true
end
