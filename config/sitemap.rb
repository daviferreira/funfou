# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.funfou.com.br"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host

  add perguntas_path, :priority => 0.7, :changefreq => 'weekly'
  add about_path
  add contact_path
  
  Question.published.each do |question|
    add pergunta_path(question), :lastmod => question.updated_at
  end
  
  add categorias_path, :priority => 0.7
  Category.all.each do |category|
    add categoria_path(category), :lastmod => category.updated_at
  end

  User.all.each do |user|
    if user.active?
      add usuario_path(user), :lastmod => user.updated_at, :changefreq => 'weekly'
    end
  end

  add new_user_path
  add login_path
  
end
