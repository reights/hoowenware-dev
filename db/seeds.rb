# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'faker'

User.destroy_all

15.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.password = 'password'
  user.password_confirmation = 'password'
  user.provider = [:gmail, :facebook].sample
  user.avatar = 'http://lorempixel.com/400/200'
  user.gender = ['male', 'female'].sample
  user.status = ['single','married','divorced','involved'].sample
  # user.organization = ['',Faker::Company.name, ''].sample
  user.zip_code = Faker::Address.zip_code
  # user.birthdate = Date.parse(Time.at(rand * Time.new(1996,12,31).to_i).to_s)
  user.mobile_number = Faker::PhoneNumber.cell_phone
  user.dietary_pref = ['none', 'vegan','kosher','vegitarian','allergnic','other'].sample
  user.roommate_pref = ['none','any','single female', 'single male','group females','group males'].sample

  user.save!

  subject = [Faker::Company.name, Faker::Address.city, Faker::Company.catch_phrase].sample
  predicate = ['Company Retreat', 'Ski Trip', 'Boat Ride', 'Music Festival', 
                'Seminar', 'Annual Converence', 'Reunion', 'Chartity Tournament', 
                'Weekend Getaway', 'trip', 'Hackathon', 'Telethon', 'Meetup',
                'Meet and Greet', 'Flashmob', 'Meeting', 'Movie Night', 'Bowling Night',
                'Fun Night', 'Premier Week Party', 'Speed Dating trip', 'Hiking Trip'].sample
  suffix = ['','2014',''].sample
  date =  rand((365-Date.today.yday()).days).from_now
  trip = Trip.new
  trip.title = subject + ' ' + predicate + ' ' +suffix
  # trip.organization = ['',subject].sample
  trip.hash_tag = '#'+[subject, predicate, trip.title, predicate+''+suffix].sample.split.map(&:capitalize)*' '.delete(' ')
  # trip.tag_names = [Faker::Company.catch_phrase, Faker::Company.bs].sample
  trip.start_date = date
  trip.end_date = (date + rand(0..5).days)
  trip.location = Faker::Address.city + ', ' + Faker::Address.state
  trip.user_id = user.id

  trip.save!

end

puts "Database seeded with test data."
