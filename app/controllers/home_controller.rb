class HomeController < ApplicationController
  def index
    @sites = User.order("RANDOM()").first(3)
  end

  def rules

  end
end
