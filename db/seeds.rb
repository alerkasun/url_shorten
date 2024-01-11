require 'faker'
Link.delete_all

20.times do |i|
  original_url = Faker::Internet.url
  short_url = SecureRandom.hex(3)

  Link.create(
    original_url: original_url,
    short_url: short_url
  )
end

puts "Generated 20 links."
