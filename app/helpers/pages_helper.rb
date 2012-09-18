module PagesHelper
  def markdown(string)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    renderer.render(string).html_safe
  end
end