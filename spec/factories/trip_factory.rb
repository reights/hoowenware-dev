# event factory for integration testing
def gen_random_date(from=Time.now, limit=5, format="%m/%d/%y")
  require 'time'

  def set_month(date)
    if date.day == Time.now.day
      return rand(date.month..12)
    else
      return date.month
    end
  end

  if from.is_a? Time
    month = self.set_month(from)
  elsif from.is_a? Date
    from = Time.new(from.year, from.month, from.day)
    month = self.set_month(from)
  else
    from = Time.strptime(from, format)
    month = self.set_month(from)
  end

  if from.month == Time.now.month && from.day == Time.now.day
    day = rand(from.day..31)
  else
    day = from.day
  end

  while day > 31 do
    day = rand(day..31)
  end

  date = Time.new(from.year, month, day).strftime(format)
end



FactoryGirl.define do
  start = ''
  sequence(:title) {|n| "An Example Trip ##{n}"}
  sequence(:start_date) {|n| start = gen_random_date }
  sequence(:end_date) {|n| gen_random_date(start) }
  sequence(:location) {|n| "Location ##{n}"}

	factory :trip do
		title { generate(:title) }
		start_date { generate(:start_date) } 
		end_date { generate(:end_date) } 
		location { generate(:location) }
	end
end