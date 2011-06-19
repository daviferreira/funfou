# -*- encoding : utf-8 -*-
class UserMailer < ActionMailer::Base
  default :from => "contato@funfou.com.br"
  
  def password_instructions(user, host)
    @user = user
    @url = "http://" + host + "/senha/" + user.salt 
    mail(:to => user.email,
         :subject => "Instruções para criar uma nova senha no Funfou")
  end
end
