ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'data_mapper'
require 'dm-postgres-adapter'
require './app/models/link'

class BookmarkManager < Sinatra::Base
  DataMapper::Logger.new($stdout, :debug)

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb(:'links/index')
  end

  get '/links/new' do
    erb(:'links/new')
  end

  post '/links' do
    Link.create(url: params[:url], title: params[:title])
    redirect '/links'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
