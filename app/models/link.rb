class Link < ApplicationRecord
  before_create :generate_short_url

  validates :original_url, presence: true, url: true
  validates :visit_count, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    %w[original_url short_url visit_count created_at updated_at]
  end

  def increment_visit_count
    self.increment!(:visit_count)
  end

  def valid_password?(submitted_password)
    self.password == submitted_password
  end

  private

  def generate_short_url
    loop do
      self.short_url = SecureRandom.urlsafe_base64(6)
      break unless Link.exists?(short_url: self.short_url)
    end
  end
end