atom_feed do |feed|
  feed.title("Funfou.com.br - " + @question.title)
  feed.updated(@answers.first.created_at)

  for answer in @answers
    next if answer.updated_at.blank?  
      feed.entry(answer, :url => pergunta_path(@question)) do |entry|
        #entry.title(answer.title)  
        entry.content(answer.content, :type => 'html')
        entry.updated(answer.updated_at.strftime("%Y-%m-dT%H:%M:%SZ"))
        entry.author do |author|  
          author.name(User.find(answer.user_id).name)
        end
      end
    end
end