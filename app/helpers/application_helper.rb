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

  def remove_links_and_images string
    linked = string.gsub( %r{http://[^\s<]+} ) do |url|
      if url[/(?:png|jpe?g|gif|svg)$/]
        ""
      else
        ""
      end
    end
    string = linked
  end

  def get_all_images string
    arr = []
    linked = string.gsub( %r{http://[^\s<]+} ) do |url|
      if url[/(?:png|jpe?g|gif|svg)$/]
        arr << url
      else
        #do nothing
      end
    end
    return arr
  end

  def truncate_to_first_paragraph(string)
    string = string.split("\\n")[0]
  end
end
