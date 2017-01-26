class TagAdder

  def self.add_tags(tags, link)
      tags.each do |item|
        tag = Tag.first_or_create(name: item)
        link.tags << tag
        link.save
      end
    end
  end
