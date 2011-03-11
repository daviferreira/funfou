# == Schema Information
# Schema version: 20110308151603
#
# Table name: favorites
#
#  id          :integer         not null, primary key
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Favorite < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	
	default_scope :order => 'favorites.created_at DESC'
end
