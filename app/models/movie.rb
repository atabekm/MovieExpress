class Movie < ActiveRecord::Base
  has_attached_file :cover, styles: { medium: "488x720>", thumb: "244x360>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  has_many :reviews
  has_many :taggings
  has_many :tags, through: :taggings

  def to_s
    title
  end

  def tags_list=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip.downcase).first_or_create!
    end
  end

  def tags_list
    self.tags.map(&:name)
  end

  def self.search(query)
    if query
      where('title LIKE ?', "%#{query}%")
    end
  end
end
