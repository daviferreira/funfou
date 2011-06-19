# -*- encoding : utf-8 -*-
class AddPublishedToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :published, :boolean
  end

  def self.down
    remove_column :answers, :published
  end
end
