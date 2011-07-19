require 'spec_helper'

describe "FriendlyForwardings" do

  it "should forward to the requested page after signin" do
    user = Factory(:user)
    visit edit_user_path(user)
    fill_in "Seu e-mail", :with => user.email
    fill_in "Sua senha", :with => user.password
    click_button "Login"
    response.should render_template('users/edit')
  end

end
