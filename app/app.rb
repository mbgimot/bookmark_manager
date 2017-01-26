ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  DataMapper::Logger.new($stdout, :debug)

  before do
    @user = User.instance
  end
  
  get '/' do
    erb(:'login/sign_up')
  end

  post '/signup' do
    @user = User.add(params[:email], params[:password])
    redirect '/links'
  end

  get '/links' do
    @user
    @links = Link.all
    erb(:'links/index')
  end

  get '/links/new' do
    erb(:'links/new')
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    tags = params[:tags].split(", ")
    TagAdder.add_tags(tags, link)
    redirect '/links'
  end

  get '/tags' do
    erb :'tags/search'
  end

  get '/tags/name' do
    tag = Tag.all(name: params[:search_tag])
    @links = tag ? tag.links : []
    erb :'links/index'
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
