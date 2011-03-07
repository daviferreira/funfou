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
end
