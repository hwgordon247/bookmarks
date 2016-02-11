ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  helpers do
    def session_user
      @session_user ||= User.get(session[:user_id])
    end
  end


  get '/' do
    erb :'users/sign_up'
  end

  post '/sign_up' do
    @user = User.new(user_name: params[:user_name], password: params[:password], email: params[:email], password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/welcome'
    else
      flash.now[:notice]= 'Ooops, your passwords didn\'t match'
      erb :'users/sign_up'
    end
  end


  get '/welcome' do
    # if session_user.nil?
    #   @user = nil
    # else
      @user = session_user.user_name
    # end
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
    # require 'pry'; binding.pry
    erb :'links/search_tag'
   end




  run! if app_file == $0
end
