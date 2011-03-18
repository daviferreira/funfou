class AddCachedSlugToCategories < ActiveRecord::Migration
  
  def self.up
    add_column :categories, :cached_slug, :string
    add_index  :categories, :cached_slug
  end

  def self.down
    remove_column :categories, :cached_slug
  end
  
end
