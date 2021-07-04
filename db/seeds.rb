# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
unless User.where(role: "Doctor").any?
  User.create(
    id: 1,
    email: "doctor-1@example.com",
    password: "password",
    password_confirmation: "password",
    name: "Doctor-1",
    role:			"Doctor"
  )
  puts "Doctor created"
end

unless User.where(role: "Patient").any?
  User.create(
    id: 2,
    email: "patient-1@example.com",
    password: "password",
    password_confirmation: "password",
    name: "patient-1",
    role:			"Patient"
  )
  puts "Patient created"
end
