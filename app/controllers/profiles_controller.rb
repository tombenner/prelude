class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    render_404 if @user.blank?
  end
end
