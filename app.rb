require 'sinatra'
require 'sinatra/activerecord'
require 'slim'

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

  def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      false
    end
  end
end

get '/' do
  users = User.all.order(:id)
  slim :index, :layout => :application
end

get '/site/:id/prev' do

end

get '/site/:id/next' do

end

get '/site/:id' do
  site = User.find(params[:id])
end

get '/login' do

end

post '/login' do

end

post '/logout' do

end
