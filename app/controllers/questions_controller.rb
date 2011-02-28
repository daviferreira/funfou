class QuestionsController < ApplicationController
   before_filter :authenticate, :only => [:create, :destroy]

  def show
  end
  
  def create
  end

  def destroy
  end
end
