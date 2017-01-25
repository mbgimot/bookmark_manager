ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'

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
    link = Link.create(url: params[:url], title: params[:title])
    tag = Tag.first_or_create(name: params[:tags])
    link.tags << tag
    link.save
    redirect '/links'
  end

  get '/tags' do
    erb :'tags/search'
  end

  get '/tags/bubbles' do
    @links = Link.all
    erb :'tags/bubbles'
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
