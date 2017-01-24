require 'dm-postgres-adapter'
require 'data_mapper'

class Link
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :url, String, length: 2000
end

DataMapper.setup(:default, 'postgres://localhost/bookmark_manager_test')
DataMapper.finalize
DataMapper.auto_upgrade!
