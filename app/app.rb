require 'sinatra/base'
require_relative 'models/link.rb'
require_relative 'models/tag.rb'
require_relative 'models/user.rb'
require_relative 'data_mapper_setup.rb'

class BookmarkManager < Sinatra::Base

  ENV['RACK_ENV'] ||= 'development'
  # set :environment, :development

  get '/' do
    erb (:sign_up)
  end

  post '/signed_in' do
    @user = User.create(:name => params[:name], :email => params[:email], :password => params[:password] )
    redirect '/links'
  end

  get '/links' do
    @list = Link.all
    erb(:links)
  end

  get '/links/new' do
    erb(:new_link)
  end

  post '/links' do
    @link = Link.create(:title => params[:title], :url => params[:url])
    params[:tag].split(",").map(&:strip).each do |tag|
        # if tag == Tag.first(tag: tag)
        #   @link.tags << tag
        # else
          @link.tags << Tag.first_or_create(tag: tag)
        # end
      end
      @link.save
    redirect '/links'
  end

  post '/tags' do
    @search = params[:search]
    redirect "/tags/#{@search}"
  end

  get '/tags/:search' do
    # check it's a tag
    tag = Tag.first(tag: params[:search])
    @list = tag ? tag.links : []
    erb(:links)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
