class Link
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :url, String, length: 2000
  has n, :tags, through: Resource
  
end
