require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end

def age(dob)
  now = Time.now.utc.to_date
  now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
end

def randomDate(params={})
  years_back = params[:year_range] || 5
  latest_year  = params [:year_latest] || 0
  year = (rand * (years_back)).ceil + (Time.now.year - latest_year - years_back)
  month = (rand * 12).ceil
  day = (rand * 31).ceil
  series = [date = Time.local(year, month, day)]
  if params[:series]
    params[:series].each do |some_time_after|
      series << series.last + (rand * some_time_after).ceil
    end
    return series
  end
  date
end

def make_users
  admin = User.create!(:login => "Example User",
                       :email => "example@railstutorial.org",
                       :password => "foobar",
                       :password_confirmation => "foobar",
											 :birthday => randomDate(:year_range => 60, :year_latest => 22),
								 			 :age => age(randomDate(:year_range => 60, :year_latest => 22)))
  admin.toggle!(:admin)
  99.times do |n|
    login  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
		date = randomDate(:year_range => 60, :year_latest => 22)
    User.create!(:login => login,
                 :email => email,
                 :password => password,
                 :password_confirmation => password,
								 :birthday => date,
								 :age => age(date))
  end
end

def make_microposts
  User.all(:limit => 6).each do |user|
    50.times do
      content = Faker::Lorem.sentence(5)
      user.microposts.create!(:content => content)
    end
  end
end

def make_relationships
  users = User.all
  user  = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end
