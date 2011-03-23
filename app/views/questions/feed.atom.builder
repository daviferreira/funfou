atom_feed do |feed|
  feed.title("Funfou.com.br - Perguntas")
  feed.updated(@questions.first.created_at)

  for question in @questions
    next if question.updated_at.blank?  
      feed.entry(question, :url => pergunta_path(question)) do |entry|
        entry.title(question.title)  
        entry.content(question.content, :type => 'html')
        entry.updated(question.updated_at.strftime("%Y-%m-dT%H:%M:%SZ"))
        entry.author do |author|  
          author.name(User.find(question.user_id).name)
        end
      end
    end
end