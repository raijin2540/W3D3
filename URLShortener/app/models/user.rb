class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many :created_urls,
  primary_key: :id,
  foreign_key: :creator_id,
  class_name: 'ShortenedUrl'

  has_many :visits,
  primary_key: :id,
  foreign_key: :visitor_id,
  class_name: :Visit

  has_many :visited_urls,
    through: :visits,
    source: :url
end
