module QuestionsHelper 
	def meta_in_words(total, forms)
		if total == 0
			"sem #{forms[:plural]}"
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
  
  def get_total_answers(answers)
    if signed_in? and current_user.admin?
      answers.count
    else
      answers.published.count
    end
  end
  
  def link_to_publish(obj)
    if signed_in? and current_user.admin?
      name = obj.to_s.split(":").first.sub(/#</, '')
      if name == "Answer"
        link = publicar_resposta_path(obj)
      else
        link = publicar_pergunta_path(obj)
      end
      if obj.published?
        link_to "Está publicada", link, :class => 'unpublish'
      else
        link_to "Não está publicada", link, :class => 'publish'
      end
    end
  end
  
end
