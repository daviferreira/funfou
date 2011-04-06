class VotesController < ApplicationController
	before_filter :authenticate

  def up    
    @question = Question.find_using_slug(params[:id])
    @answer = Answer.find(params[:answer_id])
    
    if @answer.user_id == current_user.id
      @answer = nil
      @modified_answer = nil
    else
      @modified_answer = recalculate_answers_scores(@question)
      current_user.vote!(@question, @answer, 1)
      @answer.reload
      @answer.update_attributes(:score => @answer.score + 1)
    end
    
    respond_to do |format|
			format.html { redirect_to pergunta_path(@question) }
			format.js
		end
  end
  
  private
  
    def recalculate_answers_scores(question)
      answers = Answer.where("question_id = ?", question.id)

      unless answers.empty?
        answers_id = ""
        answers.each do |answer|
          answers_id += "#{answer.id},"
        end
        answers_id.sub!(/,$/, '')
        votes = Vote.where("user_id = #{current_user.id} AND answer_id IN (#{answers_id})")
        unless votes.empty?
          votes.each do |vote|
            @modified_answer = Answer.find(vote.answer_id)
            @modified_answer.update_attributes(:score => @modified_answer.score - vote.value)
            vote.destroy
          end
          @modified_answer
        end
      end
    end

end
