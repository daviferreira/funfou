# -*- encoding : utf-8 -*-
class VotesController < ApplicationController
	before_filter :authenticate

  def up    
    @answer = Answer.find(params[:id])
    @question = @answer.question
    
    unless @answer.user_id == current_user.id
      @question.answers.each do |answer|
        answer.votes.each do |vote|
          if vote.user_id == current_user.id
            vote.destroy
            @modified_answer = answer
          end
        end
      end
      current_user.vote!(@question, @answer, 1)
      @question.reload
      recalculate_answers_scores(@question)
      @answer.reload
    end
    
    respond_to do |format|
			format.html { redirect_to pergunta_path(@question) }
			format.js
		end
  end
  
  private
    
    def recalculate_answers_scores(question)
      question.answers.each do |answer|
        @score = 0
        answer.votes.each do |vote|
          @score += 1
        end
        answer.update_attributes(:score => @score)
      end
    end

end
