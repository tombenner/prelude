module ApplicationHelper
  def page_title(page_title=nil)
    if page_title.nil?
      return get_page_title
    end
    @page_title = page_title
  end
  
  def get_page_title
    if !@page_title.blank?
      separator = " | "
      if @page_title.is_a?(Array)
        @page_title = @page_title.reverse.join(separator)
      end
      "#{@page_title}#{separator}#{SiteSettings.site_name}"
    else
      SiteSettings.site_name
    end
  end
end
