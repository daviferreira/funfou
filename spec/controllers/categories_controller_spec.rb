# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CategoriesController do
  render_views

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
    
    it "should have the right title" do
      get :index
      response.should have_selector(:title, :content => "Todas as categorias")
    end
    
    it "should have an element for each category" do
			get :index
			Category.all.each do |category|
				response.should have_selector('li', :content => category.name)
			end
		end
  end
  
  describe "GET 'show'" do
    
  end
  
  describe "GET 'feed'" do
    
  end

end