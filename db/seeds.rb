# Seeds file for development
# Takes time to run, generates 20 trips, with a random number of invitees,
# attendees, decliners and undecided users
# Alvaro, Muir, @alvaromuir


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

lampkin_trip = Trip.create(:title => 'Hoowenware Launch Party',
                          :location => 'Oranjestad, Aruba',
                          :start_date => '05/15/14',
                          :end_date => '05/16/14',
                          :hash_tag => '#hooWenWare',
                          :user_id => lampkin.id)
lampkin_trip.save!

def create_user
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
  return user
end

def create_trip(user)
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
  return trip
end

def generate_invites(trip, count)
  count.times {
    @user = create_user
    trip.invitations.build(user_id:@user.id, email: @user.email, 
                            full_name: @user.full_name, avatar: @user.avatar).save!
  }
end

def generate_rsvps(trip, count, answer)
  count.times {
    @user = create_user
    trip.rsvps.build(user_id:@user.id, response: answer).save!
  }
end

# Trips, Invitations & RSVPs
15.times do
  @trip = create_trip(create_user)
  generate_invites(@trip, rand(3..10))
  generate_rsvps(@trip, rand(3..7), 'yes')
  generate_rsvps(@trip, rand(2..5), 'maybe')
  generate_rsvps(@trip, rand(1..4), 'no')
end

  generate_invites(lampkin_trip, rand(7..20))
  generate_rsvps(lampkin_trip, rand(3..11), 'yes')
  generate_rsvps(lampkin_trip, rand(3..11), 'maybe')
  generate_rsvps(lampkin_trip, rand(3..11), 'no')

# Groups
['Kentucky U. Wildcats Alumn', 'Doctors Without Borders', 'Wine Country Lovers',
  'Traveling Photographers', 'Start-Up Junkies' ].each { |g| Group.create(name: g)}


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
