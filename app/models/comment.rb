# == Schema Information
# Schema version: 20110308151603
#
# Table name: comments
#
#  id          :integer         not null, primary key
#  comment     :text
#  user_id     :integer
#  question_id :integer
#  answer_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Comment < ActiveRecord::Base
end
