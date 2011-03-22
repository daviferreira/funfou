module ApplicationHelper

	def title
		base_title = "Funfou"
		if @title.nil?
			@title = "Perguntas e respostas - de programador para programador"
		end	
		"#{base_title} | #{@title}"
	end
	
	def logo
	  image_tag("funfou-b32.png", :alt => "Funfou")
  end

end
