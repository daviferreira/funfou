require 'spec_helper'

describe QuestionsController do
  render_views
  
  describe "GET 'index'" do
    
  end
  
  describe "GET 'show'" do
    
  end
  
  describe "GET 'new'" do
    
  end

  describe "POST 'create'" do
    
    describe "as a non-signed-in user" do
      it "should deny access" do
        post :create
        response.should redirect_to(login_path)
      end
    end
    
    describe "as a signed-in user" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @attr = {:title => "Question title.", 
                 :content => "Question content.", 
                 :tags => ["php","ruby"]}
      end
      
      it "should be successful" do
        lambda do
          post :create, :question => @attr
        end.should change(Question, :count).by(1)
      end
      
      describe "success" do
        
        it "should be published" do
          post :create, :question => @attr
          Question.last.should be_published
        end
        
      end
      
    end
    
  end
  
  describe "POST 'update'" do
    
  end
  
  describe "DELETE 'destroy'" do
    
  end
  
end