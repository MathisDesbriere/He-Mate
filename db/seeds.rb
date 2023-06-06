# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'open-uri'

Activity.destroy_all
Trip.destroy_all

# puts " creating users"

10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

# puts "user's done"
users = User.all

# Seed data for Trips

5.times do
  trip = Trip.new(
    title: Faker::Lorem.word,
    user: users.sample,
    like: 10,
    description: Faker::Lorem.paragraph
  )
  trip.user = users.sample
  trip.save!
end


# Seed data for Activities
trip = Trip.first
Activity.create(trip: trip, title: "Activity 1", link: "https://example.com/activity1")
Activity.create(trip: trip, title: "Activity 2", link: "https://example.com/activity2")
