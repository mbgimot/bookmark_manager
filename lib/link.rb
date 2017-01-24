require 'dm-postgres-adapter'
require 'data_mapper'

class Link
  include DataMapper::Resource

  property :id, Serial
  property :url, String, length: 2000
end
