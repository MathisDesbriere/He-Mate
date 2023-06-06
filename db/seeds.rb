# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Seed data for Trips
user = User.first
Trip.create(title: "Trip 1", user: user, like: 10, description: "Trip 1 description")
Trip.create(title: "Trip 2", user: user, like: 5, description: "Trip 2 description")

# Seed data for Activities
trip = Trip.first
Activity.create(trip: trip, title: "Activity 1", link: "https://example.com/activity1")
Activity.create(trip: trip, title: "Activity 2", link: "https://example.com/activity2")
