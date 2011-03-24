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
end