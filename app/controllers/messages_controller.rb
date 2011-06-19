# -*- encoding : utf-8 -*-
class MessagesController < ApplicationController
  
  def create
    @message = Message.new(params[:message])
    if @message.valid?
      MessageMailer.contact(@message).deliver
      flash[:notice] = "Mensagem enviada! Obrigado por entrar em contato."
      redirect_to root_url
    else
      flash[:error] = "Todos os campos são de preenchimento obrigatório."
      render "pages/contact"
    end
  end

end
