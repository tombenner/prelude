class PagesController < ApplicationController
  def show
    @page = Page.find_by_key(params[:key])
    render_404 if @page.blank?
  end
end
