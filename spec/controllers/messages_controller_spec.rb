# -*- encoding : utf-8 -*-
require 'spec_helper'

describe MessagesController do
  render_views

  describe "POST 'create'" do
    
    it "should not deliver message with invalid params" do
      post :create, :message => {:name => "", :email => "invalid", :content => ""}
      flash[:error].should =~ /obrigatório/i
      response.should render_template("pages/contact")
    end
    
    it "should deliver message with valid params" do
      post :create, :message => {:name => "test", :email => "test@test.com", :content => "message"}
      flash[:success].should =~ /enviada/i
      response.should redirect_to(root_path)
    end
    
  end
end
