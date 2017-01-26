ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'encrypted_cookie'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  use Rack::Session::EncryptedCookie,
    secret: 'ebb09be68821e5f929cce9f98c86efb4daee51287d42d840b388a112d7b3cda8'

  DataMapper::Logger.new($stdout, :debug)

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    redirect '/users/new'
  end

  get '/users/new' do
    erb(:'users/new')
  end

  post '/signup' do
    user = User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/links'
  end

  get '/links' do
    current_user
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
