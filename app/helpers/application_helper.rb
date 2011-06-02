module ApplicationHelper

	def title
		if @title.nil?
			@title = "Funfou.com.br - Perguntas e respostas sobre PHP, Ruby on Rails, Python, Java, HTML, CSS, jQuery, ASP, .net"
		end	
		"#{@title}"
	end

  def meta_description
    if @meta_description.nil?
      @meta_description = "Perguntas e respostas sobre programação: PHP, MySQL, Ruby on Rails, Python, Java, HTML, CSS, jQuery, ASP, .net."
    end
    @meta_description
  end

	def logo
	  image_tag("funfou-b32.png", :alt => "Funfou")
  end

end
