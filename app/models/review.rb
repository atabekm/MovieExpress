class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  def created
    created_at.strftime("%H:%M %Y-%m-%d")
  end
end
