class Favorite < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	
	default_scope :order => 'favorites.created_at DESC'
end
