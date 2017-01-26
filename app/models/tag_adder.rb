class TagAdder
  def self.add_tags(tags, link)
    tags.each do |item|
      link.tags << Tag.first_or_create(name: item)
    end
    link.save
  end
end
