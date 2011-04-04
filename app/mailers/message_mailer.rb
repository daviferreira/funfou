class MessageMailer < ActionMailer::Base
  default :to => "contato@funfou.com.br"
  
  def contact(message)
    @message = message
    mail(:from => message.email,
         :subject => "Contato Funfou")
  end
end
