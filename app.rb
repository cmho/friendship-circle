require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/base'
require 'sinatra/partial'
require 'sinatra/content_for'
require 'bcrypt'
require 'slim'
require "sinatra/config_file"
require "rack/csrf"

config_file 'config/application.yml'

set :database_file, "config/database.yml"
set :partial_template_engine, :slim
enable :partial_underscores

configure do
  use Rack::Session::Cookie, :secret => "YOUR SECRET GOES HERE"
  use Rack::Csrf, :raise => true
end

class User < ActiveRecord::Base
  include BCrypt
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

  def password
		@password ||= Password.new(password_digest)
	end

	def password=(new_password)
		@password = Password.create(new_password)
		self.password_digest = @password
	end

  def is_admin?
    self.is_admin
  end

  def is_approved?
    self.is_approved
  end
end

helpers do
	def is_logged_in?
		return session[:user].present?
	end

  def current_user
    User.find(session[:user])
  end

  def csrf_token
    Rack::Csrf.csrf_token(env)
  end

  def csrf_tag
    Rack::Csrf.csrf_tag(env)
  end
end

get '/' do
  @sites = User.all.order(:id)
  slim :index, :layout => :application
end

get '/site/:id/prev' do
  user = User.find(params[:id])
  redirect user.prev.site_url
end

get '/site/:id/next' do
  user = User.find(params[:id])
  redirect user.next.site_url
end

get '/site/:id' do
  @site = User.find(params[:id])
end

get '/join' do
  slim :join
end

post '/join' do
  @user = User.new({
    email: params[:user][:email],
    site_name: params[:user][:site_name],
    site_url: params[:user][:site_url],
    site_description: params[:user][:site_description]
  })
	if params[:password] == params[:confirm_password]
		@user.password = params[:password]
		if @user.save
			session[:user] = @user.id
			flash[:success] = "Thanks for registering, #{@user.username}! You are now logged in."
			redirect to('/')
		else
			flash[:error] = "There was an error with your registration."
			slim :join
		end
	else
		flash[:error] = "Your password confirmation did not match your password."
		slim :join
	end
end

get '/login' do
  slim :login, :layout => :application
end

post '/login' do
  @user = User.find_by_email(params[:user][:email])
  if @user.password == params[:user][:password]
    session[:user] = @user.id
    flash[:success] = "Welcome, #{current_user.display_name}!"
    redirect '/'
  else
    flash[:error] = "Your username or password was incorrect."
    slim :login
  end
end

post '/logout' do
  if session[:user]
		session[:user] = nil
	end
	redirect '/'
end

get '/forgot_password' do
  slim :forgot_password, :layout => :application
end

post '/forgot_password' do
  @user = User.find_by_email(params[:user][:email])
  if @user.present?
    user.reset_token = Array.new(10).map { (65 + rand(58)).chr }.join
    flash[:success] = "An email allowing you to reset your password has been sent. Please check your inbox."
    # send the email
  else
    flash[:error] = "No user with that email address found."
    redirect '/forgot_password'
  end
end

get '/reset_password' do
  slim :reset_password, :layout => :application
end

post '/reset_password' do
  @user = User.find(params[:user][:id])

end
