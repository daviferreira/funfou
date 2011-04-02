module UsersHelper
  
  def first_name(name)
    name = name.split
    name.first
  end
  
  def valid_url_for(str)
    if str[0,7] != 'http://' and str[0,8] != 'https://'
      'http://' + str 
    end
    str
  end
  
  def avatar(user, height)
    height = 28 if height.nil? or height.blank?
    if user.avatar.exists?
      img = image_tag(user.avatar.url(:thumb), :height => height)
    else
      img = image_tag("avatar.png", :height => height)
    end
    link_to img, user
  end
  
  def stats_text(user)
    txt = first_name(user.name)
    perguntas = user.questions.published.count;
    respostas = user.answers.published.count;
    favoritos = user.favorites.count
    
    if perguntas == 1
      txt += " já fez somente 1 pergunta e "
    elsif perguntas > 1
      txt += " já fez #{perguntas} perguntas e "
    else
      txt += " ainda não fez nenhuma pergunta e "
    end

    if respostas == 1
      txt += "participou com 1 resposta. "
    elsif respostas > 1
      txt += "participou com #{respostas} respostas. "
    else
      txt += "não participou com nenhuma resposta. "
    end

    if favoritos == 1
      txt += "Possui 1 pergunta favorita. "
    elsif favoritos > 1
      txt += "Possui #{favoritos} perguntas favoritas. "
    else
      txt += "Não tem nenhuma pergunta nos seus favoritos. "
    end
    
    if user.last_login.blank?
      txt += "Ainda não acessou sua conta."
    else
      txt += "Esteve aqui pela última vez há " + time_ago_in_words(user.last_login) + "."
    end
    
    txt
  end
  
end