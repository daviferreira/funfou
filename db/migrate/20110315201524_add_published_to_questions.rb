# -*- encoding : utf-8 -*-
class AddPublishedToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :published, :boolean
  end

  def self.down
    remove_column :questions, :published
  end
end
