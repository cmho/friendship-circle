require 'sinatra'
require 'sinatra/activerecord'

set :database_file, "config/database.yml"

class User < ActiveRecord::Base
  validates_presence_of :username, :display_name, :site_name, :site_url

  def next
    next_user = User.find(self.id + 1)
    if next_user.empty?
      next_user = User.first
    end

    next_user
  end

  def prev
    prev_user = User.find(self.id - 1)
    if prev_user.empty?
      prev_user = User.last
    end

    prev_user
  end
end

get '/' do
  users = User.all.order(:id)
  render :index
end

get '/site/:id/prev' do

end

get '/site/:id/next' do

end

get '/site/:id' do
  site = User.find(params[:id])
end
