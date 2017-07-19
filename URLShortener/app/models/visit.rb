class Visit < ActiveRecord::Base
  validates :visitor_id, :shortened_url_id, presence: true

  def self.record_visit!(user, shortened_url)
      Visit.create!(visitor_id: user.id, shortened_url_id: shortened_url.id)
  end

  belongs_to(
  :visitor,
  primary_key: :id,
  foreign_key: :visitor_id,
  class_name: 'User'
  )

  belongs_to(
  :url,
  primary_key: :id,
  foreign_key: :shortened_url_id,
  class_name: 'ShortenedUrl'
  )

end
