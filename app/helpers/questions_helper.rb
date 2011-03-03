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
end
