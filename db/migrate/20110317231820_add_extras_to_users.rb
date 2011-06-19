# -*- encoding : utf-8 -*-
class AddExtrasToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :site, :string
    add_column :users, :twitter, :string
    add_column :users, :github, :string
    add_column :users, :cidade, :string
    add_column :users, :bio, :string
  end

  def self.down
    remove_column :users, :bio
    remove_column :users, :cidade
    remove_column :users, :github
    remove_column :users, :twitter
    remove_column :users, :site
  end
end
