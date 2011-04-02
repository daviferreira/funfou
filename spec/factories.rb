Factory.define :user do |user|
  user.name                  	"Michael Hartl"
  user.email                 	"mhartl@example.com"
  user.password              	"foobar"
  user.password_confirmation 	"foobar"
	user.cached_slug						"michael-hartl"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.sequence :name do |n|
  "Person #{n}"
end

Factory.define :question do |question|
  question.title        "Test"
  question.content      "test content"
  question.tags         [Tag.new]
  question.association  :user
end

Factory.define :answer do |answer|
  answer.content            "Test"
  answer.association        :user
  answer.association        :question
end
