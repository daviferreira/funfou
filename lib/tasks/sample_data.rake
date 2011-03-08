namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
		require 'faker'
		Rake::Task['db:reset'].invoke
    make_users
    make_questions
  end
end

def make_users
  admin = User.create!(:name => "Davi Ferreira",
                       :email => "contato@daviferreira.com",
                       :password => "foobar",
                       :password_confirmation => "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_questions
  User.all(:limit => 6).each do |user|
    50.times do
      user.questions.create!(:title => Faker::Lorem.sentence(5),
                             :content => Faker::Lorem.sentence(20))
    end
  end
end
