require 'sinatra/base'
require 'data_mapper'
require 'dm-postgres-adapter'
require './lib/link'


class BookmarkManager < Sinatra::Base
  DataMapper.setup(:default, 'postgres://localhost/bookmark_manager')
  DataMapper::Logger.new($stdout, :debug)

  get '/' do
    DataMapper.finalize
    DataMapper.auto_upgrade!
    Link.create(url: 'http://www.google.com')
    @link = Link.first(url: 'http://www.google.com')
    erb(:index)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
