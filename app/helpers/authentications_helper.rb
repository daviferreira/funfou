# -*- encoding : utf-8 -*-
module AuthenticationsHelper

  def omniauth_providers
    providers = ["twitter", "facebook", "google_apps", "linked_in", "github"]
    html = ""
    providers.each do |p|
      unless signed_in? and current_user.authentications.find_by_provider(p)
        html += "<a href=\"/auth/#{p}\" class=\"auth_provider\">" + (image_tag "#{p}_64.png", :size => "64x64", :alt => "#{p}" + p.capitalize) + "</a>"
      end
    end
    raw(html)
  end

end
