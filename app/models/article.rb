class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_list = tags_string.split(",").collect {|el| el.strip.downcase}.uniq
    new_or_found_tags = tag_list.collect {|name| Tag.find_or_create_by(name: name)}
    self.tags = new_or_found_tags
  end
end
