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
  
  def avatar(user)
    link_to image_tag(user.avatar.url(:thumb), :width => 32), usuario_path(user) if user.avatar.exists?
  end
  
end