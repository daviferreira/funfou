# -*- encoding : utf-8 -*-
require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "should be successful" do
      get :new 
      response.should be_success
    end
  end

end
