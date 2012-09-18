module UsersHelper
  def avatar(user, options={})
    defaults = {
      :class => 'avatar',
      :div => true,
      :link => false,
      :html => {},
      :size => :medium
    }
    options.reverse_merge!(defaults)
    html = image_tag(user.avatar.url(options[:size]), options[:html])
    if options[:link]
      html = link_to(html, user_path(user))
    end
    if options[:div]
      html = '<div class="'+options[:class]+'">'+html+'</div>'
    end
    html.html_safe
  end
end