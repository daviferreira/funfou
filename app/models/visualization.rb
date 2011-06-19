# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20110308151603
#
# Table name: visualizations
#
#  id            :integer         not null, primary key
#  question_id   :integer
#  ip_address    :string(255)
#  browser_agent :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Visualization < ActiveRecord::Base
	belongs_to :question
end
