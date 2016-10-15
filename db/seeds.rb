# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:"Example User",
email:"1example0@railstutorial.org",
password:"password",
password_confirmation:"password",
admin: true,
avatar: File.new("app/assets/images/cover.jpg"),
activated: true,
activated_at: Time.zone.now
)

99.times do |n|
name = Faker::Name.name
email = "#{n}example-#{n+1}@railstutorial.org"
password = "password"
User.create!(
name:name,
email:email,
password: password,
password_confirmation:password,
avatar: File.new("app/assets/images/cover.jpg"),
activated: true,
activated_at: Time.zone.now
)
end
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  photoclip = File.new("app/assets/images/cover.jpg")
  users.each { |user| user.microposts.create!(content: content, photoclip: photoclip)}
end
# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

user2 = User.second
user.send_message(user2,"Hej","Co tam?")
user2.send_message(user,'Hej',"Spoko")
