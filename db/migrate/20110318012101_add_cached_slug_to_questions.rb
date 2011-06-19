# -*- encoding : utf-8 -*-
class AddCachedSlugToQuestions < ActiveRecord::Migration
  
  def self.up
    add_column :questions, :cached_slug, :string
    add_index  :questions, :cached_slug
  end

  def self.down
    remove_column :questions, :cached_slug
  end
  
end
