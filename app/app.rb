ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require 'encrypted_cookie'
require_relative 'data_mapper_setup'
require 'pry'

class BookmarkManager < Sinatra::Base
  register Sinatra::Flash
  use Rack::Session::EncryptedCookie,
    secret: 'ebb09be68821e5f929cce9f98c86efb4daee51287d42d840b388a112d7b3cda8'

  DataMapper::Logger.new($stdout, :debug)

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    flash[:errors]
    erb :index
    #redirect '/users/new'
  end

  post '/signin' do
    #binding.pry
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/links'
    else
      flash[:errors] = ['The email or password is incorrect.']
      redirect '/'
    end
  end

  get '/users/new' do
    session[:email] ? @email_res = session[:email] : nil
    erb(:'users/new')
  end

  post '/signup' do
    user = User.create(email: params[:email], password: params[:password], password_conf: params[:password_conf])
    if user.save
      session[:user_id] = user.id
      redirect '/links'
    else
      session[:email] = params[:email]
      flash[:errors] = user.errors.full_messages
      redirect '/users/new'
    end
  end

  get '/links' do
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
