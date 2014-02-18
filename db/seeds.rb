# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'faker'

User.destroy_all
Trip.destroy_all
Group.destroy_all

# Dev admin
User.create(:first_name => 'Hoowenware', 
            :last_name => 'Admin', 
            :email => 'admin@hoowenware.com',
            :password => 'passw0rd',
            :password_confirmation => 'passw0rd',
            :is_admin => true)

# lampkin
lampkin = User.new(:first_name => 'Stephanie',
            :last_name => 'Lampkin',
            :email => 'info@hoowenware.com',
            :password => 'passw0rd1',
            :password_confirmation => 'passw0rd1',
            :avatar => 'https://lh4.googleusercontent.com/-zZjEQIBvdzs/AAAAAAAAAAI/AAAAAAAAAJg/5sPaE3fY6zg/photo.jpg',
            :zip_code => '11692',
            :is_admin => true)

lampkin.save!

Trip.create(:title => 'Hoowenware Launch Party',
            :location => 'Oranjestad, Aruba',
            :start_date => '05/15/14',
            :end_date => '05/16/14',
            :hash_tag => '#hooWenWare',
            :user_id => lampkin.id)


# Users and Trips
30.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.password = 'password'
  user.password_confirmation = 'password'
  # user.provider = [:gmail, :facebook].sample
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

# Groups
groups = ['Kentucky U. Wildcats Alumn', 'Doctors Without Borders', 'Wine Country Lovers',
          'Traveling Photographers', 'Start-Up Junkies' ]
groups.each do |g|
  Group.create name: g
end


# Memberships
def add_members_to(group, users, starting_index=0)
  count = starting_index
  group_limit = (users.length/group.length)
  group.each_with_index do |group, index|
    member = count
    last = (index + 1) * group_limit
    Membership.create(group_id: group.id, email: users[member].email, 
                          is_active: true, is_admin: true)
    loop do
      count += 1
      member = count
      if count % (group_limit + 1) == 0
        Membership.create(group_id: group.id, email: users[member].email, 
                          is_active: true, is_admin: true)
      else
        Membership.create(group_id: group.id, email: users[member].email, 
                          is_active: true, is_admin: false)
      end
      break if count == last
    end
    count = last + 1
  end
end


dev_users = User.all
dev_groups = Group.all
add_members_to(dev_groups, dev_users, 1)

puts "Database seeded with test data."
