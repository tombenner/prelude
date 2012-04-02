module ApplicationHelper
  def page_title(page_title)
    @page_title = page_title
  end
  
  def avatar(user, options={})
    defaults = {
      :class => 'avatar',
      :div => true,
      :link => false
    }
    options = defaults.merge(options)
    html = image_tag(user.avatar.url(:thumb))
    if options[:link]
      html = link_to(html, profile_path(user))
    end
    if options[:div]
      html = '<div class="'+options[:class]+'">'+html+'</div>'
    end
    html.html_safe
  end
end
