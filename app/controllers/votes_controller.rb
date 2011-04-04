class VotesController < ApplicationController
	before_filter :authenticate

  def up    
    question = Question.find_using_slug(params[:id])
    
    answer = Answer.find(params[:answer_id])
    unless answer.user_id == current_user.id
      answer.score = 0 if answer.score.nil?
      score = answer.score + 1    
      recalculate_answers_scores(question)
      current_user.vote!(question, answer, 1)
      answer.update_attributes(:score => score)
    end 
    redirect_to pergunta_path(question)
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
          vote = votes.first
          answer = Answer.find(vote.answer_id)
          answer.update_attributes(:score => answer.score - vote.value)
          vote.destroy
        end
      end
    end

end
