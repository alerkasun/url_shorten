class Link < ApplicationRecord
  attr_accessor :generated_password
  before_create :generate_short_url, :generate_password

  validates :original_url, original_url: true
  validates :short_url, uniqueness: true
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

  def generate_password
    random_password = SecureRandom.hex(10)
    self.password = Digest::MD5.hexdigest(random_password)
  end

  private

  def generate_short_url
    loop do
      self.short_url = SecureRandom.alphanumeric(6)
      break unless Link.exists?(short_url: short_url)
    end
  end
end
