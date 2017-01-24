require 'dm-postgres-adapter'
require 'data_mapper'

class Link
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :url, String, length: 2000
end

# dev = 'postgres://localhost/bookmark_manager_development'
# tst = 'postgres://localhost/bookmark_manager_test'
# db = Sinatra::Base.development? ? dev : tst

db = 'postgres://localhost/bookmark_manager'
db += '_development' if Sinatra::Base.development?
db += '_test' if Sinatra::Base.test?

DataMapper.setup(:default, db)
DataMapper.finalize
DataMapper.auto_upgrade!
