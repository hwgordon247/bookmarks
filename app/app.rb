ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash
  use Rack::MethodOverride

  helpers do
    def session_user
      @session_user ||= User.get(session[:user_id])
    end
  end


  get '/' do
    erb :'users/sign_up'
  end
  # flash.now[:notice_user_name] = "Who are you?" unless @user_existing

  post '/sign_in' do
    @user_existing = User.authenticate(params[:existing_user_name], params[:existing_password])
    if @user_existing
      session[:user_id] = @user_existing.id
      @user = session_user.user_name
      redirect '/welcome'
    end

    if @user.nil? && User.last(user_name: params[:existing_user_name])
       flash.now[:notice_user_credentials] =  "Computer says no"
       erb :'users/sign_up'
    else
      flash.now[:notice_user_credentials] =  "Who are you?"
      erb :'users/sign_up'
    end
  end




  post '/sign_up' do
    @user = User.new(user_name: params[:user_name], password: params[:password], email: params[:email], password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/welcome'
    else
      if User.last(params[:email])
        flash.now[:notice_email]= 'Ooops, your email looks a bit fishy'
      else
        flash.now[:notice]= 'Ooops, your passwords didn\'t match'
      #@user.password == @user.password_confirmation
      end
      erb :'users/sign_up'
    end
  end


  get '/welcome' do
    @user = session_user.user_name
    erb :'users/welcome'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    params[:tags].split(", ").each {|tag| link.tags << Tag.create(name: tag)}
    link.save
    redirect '/links'
  end


  get '/tags/:name' do
    tag = Tag.all(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/search_tag'
  end

  delete '/goodbye' do
    session[:user_id] = nil
    flash.keep[:notice_goodbye] = 'We are done... don\'t come crying back to me when you loose all your bookmarks'
    redirect '/'
  end






  run! if app_file == $0
end
