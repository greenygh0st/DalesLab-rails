module ApplicationHelper
  def parse_links_and_images string
    linked = string.gsub( %r{http://[^\s<]+} ) do |url|
      if url[/(?:png|jpe?g|gif|svg)$/]
        "<img src='#{url}' />"
      else
        "<a href='#{url}'>#{url}</a>"
      end
    end
    string = linked
  end
end
