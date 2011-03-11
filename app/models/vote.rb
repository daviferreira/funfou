class Vote < ActiveRecord::Base
	attr_accessible :value, :answer_id
	belongs_to :user
	belongs_to :question
end
