# # frozen_string_literal: true

# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars',,: name: 'Lord of the Rings',])
# #   Character.create(name: 'Luke', movie: movies.first)

# require 'faker'

# Slide.destroy_all
# Comment.destroy_all
# User.destroy_all
# Role.destroy_all
# Category.destroy_all
# Organization.destroy_all
# Announcement.destroy_all
# Testimonial.destroy_all


# # Create the first admin
# admin_role = Role.create!(name: 'admin', description: 'manage the API')
# admin_user = User.create!(email: 'admin@email.com', password: 'admin_pass',
#                           first_name: 'admin_name', last_name: 'admin_name',
#                           role_id: admin_role.id)

# # #

# 40.times do |_|
#   Category.create!(name: Faker::Book.genre, description: Faker::Company.catch_phrase)
#   Organization.create!(name: Faker::TvShows::BreakingBad.character,
#     address: Faker::Address.street_address,
#     phone: Faker::Number.number(digits: 5),
#     email: Faker::Internet.email,
#     welcome_text: Faker::Books::Lovecraft.sentence,
#     about_us_text: Faker::Books::Lovecraft.sentence)
# end


# organizations=Organization.all

# 21.times do |time| 
#   Testimonial.create!(name: Faker::FunnyName.two_word_name, content: Faker::Lorem.sentence)
#   s = Slide.new(text: Faker::Books::Lovecraft.sentence,
#     order: Faker::Number.number(digits: 3),
#     organization_id:organizations.sample.id)
#   s.upload_image(Rails.root.join('spec/factories_files/test.png'))
#   s.save!
# end

# puts "Testimonials count::: #{Testimonial.count}\n"
# puts "Slides count::: #{Slide.count}\n"

# puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n"
# puts 'Same Categories:::'
# Category.all.each do |category|
#   puts "\tID: #{category.id} - NAME: #{category.name}"
# end
# puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n"

# puts "The admin ROLE is ::: \n\tid: #{admin_role.id}, name: #{admin_role.name}\n"
# puts "The admin USER is ::: \n\tid: #{admin_user.id}, email: #{admin_user.email}"
# puts "\ttoken: #{JsonWebToken.encode(user_id: admin_user.id)}"
