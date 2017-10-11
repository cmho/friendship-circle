class AdminController < ApplicationController
  before_action :check_admin

  def index
    @sites = User.all.order(:id)
  end

  def settings

  end

  protected

  def check_admin
    unless current_user.is_admin?
      redirect_to root_path
    end
  end
end
