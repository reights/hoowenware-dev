# FactoryGirl Sequences

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
  sequence(:email)            {|n| "user#{n}@example.com"}
  sequence(:first_name)       {|n| "Dev #{n}"}
  sequence(:group_name)       {|n| "An Example Group ##{n}"}
  sequence(:group_id)         {|n| "#{n}"}
  sequence(:trip_title)       {|n| "An Example Trip ##{n}"}
  sequence(:membership_email) {|n| "user#{n}@example.com"}
  sequence(:poll_title)       {|n| "An Example Poll ##{n}"}
  sequence(:start_date)       {|n| start = gen_random_date }
  sequence(:end_date)         {|n| gen_random_date(start) }
  sequence(:location)         {|n| "Location ##{n}"}
  sequence(:select_option)    {|n| "Option ##{n}"}
end