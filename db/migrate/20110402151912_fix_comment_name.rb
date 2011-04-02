class FixCommentName < ActiveRecord::Migration
  def self.up
		rename_column :comments, :comment, :content
	end

  def self.down
  end
end
