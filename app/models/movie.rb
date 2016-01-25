class Movie < ActiveRecord::Base
  has_attached_file :cover, styles: { medium: "488x720>", thumb: "244x360>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
end
