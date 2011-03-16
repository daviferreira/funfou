class UserMailer < ActionMailer::Base
  default :from => "contato@funfou.com.br"
  
  def password_instructions(user)
    @user = user
    @url = ""
    mail(:to => user.email,
         :subject => "Instruções para criar uma nova senha no Funfou")
  end
end
