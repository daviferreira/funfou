# == Schema Information
# Schema version: 20110312013903
#
# Table name: tags
#
#  id          :integer         not null, primary key
#  question_id :integer
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Tag < ActiveRecord::Base
  validates_uniqueness_of :category_id, :scope => :question_id
  
  belongs_to :question
  belongs_to :category
end
