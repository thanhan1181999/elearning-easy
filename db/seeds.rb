# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "thanhan",
    email: "nguyenthanhan1181999@gmail.com",
    password: "123456", 
    password_confirmation: "123456", 
    activated: true,
    activated_at: Time.zone.now)

    10.times do |n|
        name = Faker::Name.name
        email = "example-#{n+1}@gmail.com" 
        password = "123456"
        User.create!(name: name,
            email: email,
            password: password, password_confirmation: password,
            activated: true,
            activated_at: Time.zone.now)
    end

CourseCategory.create!(name: "English")
CourseCategory.create!(name: "Japanese")
en= CourseCategory.find(1)
jp= CourseCategory.find(2)
users = User.order(:created_at).take(6) 
20.times do
    name = Faker::Lorem.sentence(word_count: 20)
    users.each { |user| user.courses.create!(name: name, 
        course_category_id: en.id) } 
end
