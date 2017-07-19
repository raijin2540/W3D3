class ShortenedUrl < ActiveRecord::Base
  validates :creator_id, presence: true

  belongs_to(
  :creator,
  primary_key: :id,
  foreign_key: :creator_id,
  class_name: 'User'
  )

  has_many :visits,
  primary_key: :id,
  foreign_key: :shortened_url_id,
  class_name: 'Visit'

  has_many :visitors,
  -> { distinct },
  through: :visits,
  source: :visitor

  def self.create_short_url(user, long_url)
    ShortenedUrl.create!(long_url: long_url, short_url: ShortenedUrl.random_code, creator_id: user.first.id)
  end

  def self.random_code
    unique = false
    until unique
      code = SecureRandom.urlsafe_base64(16)
      unique = true unless ShortenedUrl.exists?(short_url: code)
    end
    code
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.select(:visitor_id).count
  end

  def num_recent_uniques
    self.visitors.select(:visitor_id).where('visits.updated_at < ?', 10.minutes.ago)
  end

end
