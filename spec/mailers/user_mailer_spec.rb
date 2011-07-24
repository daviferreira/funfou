# -*- encoding : utf-8 -*-
require "spec_helper"

describe UserMailer do
  before(:each) do
    @user = Factory(:user)
    @host = "localhost"
    @mail = UserMailer.password_instructions(@user, @host)
  end

  it "should render the right subject" do
    @mail.subject.should == "Instruções para criar uma nova senha no Funfou"
  end

  it "should have the right receiver" do
    @mail.to.should == [@user.email]
  end

  it "should have the right sender" do
    @mail.from.should == ["contato@funfou.com.br"]
  end

  it "should print the user name" do
    @mail.body.encoded.should match(@user.name)
  end

  it "should have a confirmation url" do
    @mail.body.should match("http://"+@host+"/senha/#{@user.salt}")
  end
end
