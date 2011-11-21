# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Category do

    before(:each) do
        @attr = {
            :name => 'Category'
        }
    end

    it "should create a category given valid attributes" do
        lambda do
            Category.create!(@attr)
        end.should change(Category, :count).by(1)
    end

    it "should require a name" do
        Category.new({:name => ''}).should_not be_valid
    end

    it "should have validate the uniqueness of a name" do
        Category.create!(@attr)
        Category.new(@attr).should_not be_valid
    end

end

# == Schema Information
#
# Table name: categories
#
#  id          :integer         not null, primary key
#  name        :text
#  created_at  :datetime
#  updated_at  :datetime
#  cached_slug :string(255)
#

