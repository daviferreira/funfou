class AddAvatarUploadedAtToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :avatar_uploaded_at, :datetime
  end

  def self.down
    remove_column :users, :avatar_uploaded_at
  end
end
