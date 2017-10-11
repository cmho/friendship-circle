class AdminController < ApplicationController
  before_action :check_admin

  def index
    @new_sites = User.where(last_reviewed: nil)
    @sites_needing_review = User.where('last_reviewed != null AND updated_at > last_reviewed').order(:id)
    @sites = User.all.order(:id)
  end

  def settings

  end

  def update_settings
    Setting.ring_name = params[:ring_name]
    Setting.ring_description = params[:ring_description]
    Setting.ring_rules = params[:ring_rules]
    Setting.high_security = params[:high_security]
    redirect_to admin_settings_path
  end

  def edit
    @site = User.find(params[:id])
  end

  def update

  end

  def destroy

  end

  protected

  def check_admin
    unless current_user.is_admin?
      redirect_to root_path
    end
  end
end
