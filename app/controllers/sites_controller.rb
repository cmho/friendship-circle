class SitesController < ApplicationController
  def index
    @sites = User.all.order(:id)
  end

  def show
    @site = User.find(params[:id])
  end
end
