module QuestionsHelper 
	def meta_in_words(total, forms)
		if total == 0
			"nenhuma #{forms[:singular]}"
		elsif total == 1
			"1 #{forms[:singular]}"
		else
			"#{total} #{forms[:plural]}"
		end
	end	
	
	def author_name(user_id)
	  if signed_in? && user_id == current_user.id
	    "você"
    else
      @user = User.find_by_id(user_id)
      link_to @user.name, @user
    end
  end
  
  def updates_since_last_login(question)
    updates = 0
    
    if session[:last_login].nil?
      session[:last_login] = Time.now
    end
    
    last_login = session[:last_login]

    unless question.answers.empty?
      question.answers.each do |answer|
        if answer.created_at > last_login
          updates += 1
        end
      end
    end
    if updates > 0
      content_tag(:span, :class => "question-updates") do
        updates.to_s
      end
    end
  end
end
