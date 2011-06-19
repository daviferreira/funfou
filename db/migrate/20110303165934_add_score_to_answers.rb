# -*- encoding : utf-8 -*-
class AddScoreToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :score, :integer
  end

  def self.down
    remove_column :answers, :score
  end
end
