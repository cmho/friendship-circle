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
    @site = User.find(params[:id])
    if @site.update_attributes(site_params)

    else

    end
  end

  def approve
    @site = User.find(params[:id])
    @site.last_reviewed = DateTime.now
    if @site.save!
      return true
    end

    return false
  end

  def deactivate
    @site = User.find(params[:id])
    @site.last_reviewed = DateTime.now
    @site.is_active = false
    if @site.save!
      return true
    end

    return false
  end

  def destroy
    @site = User.destroy(params[:id])
    redirect_to admin_path
  end

  protected

  def check_admin
    unless current_user.is_admin?
      redirect_to root_path
    end
  end

  private

  def site_params
    params.require(:site).permit(:site_name, :site_url, :site_description)
  end

  def user_params
    params.require(:user).permit(:display_name, :email, :password)
  end
end
