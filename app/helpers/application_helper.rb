module ApplicationHelper

	def title
		base_title = "Funfou"
		if @title.nil?
			@title = "Perguntas e respostas - de programador para programador"
		end	
		"#{base_title} | #{@title}"
	end

  def meta_description
    if @meta_description.nil?
      @meta_description = "Site de perguntas e respostas para programadores e profissionais da área de TI."
    end
    @meta_description
  end

	def logo
	  image_tag("funfou-b32.png", :alt => "Funfou")
  end

end
