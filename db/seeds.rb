# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(name: "thanhan",
#     email: "nguyenthanhan1181999@gmail.com",
#     password: "123456", 
#     password_confirmation: "123456", 
#     activated: true,
#     activated_at: Time.zone.now)

#     10.times do |n|
#         name = Faker::Name.name
#         email = "example-#{n+1}@gmail.com" 
#         password = "123456"
#         User.create!(name: name,
#             email: email,
#             password: password, password_confirmation: password,
#             activated: true,
#             activated_at: Time.zone.now)
#     end

# CourseCategory.create!(name: "English")
# CourseCategory.create!(name: "Japanese")
# en= CourseCategory.find(1)
# jp= CourseCategory.find(2)
# users = User.order(:created_at).take(6) 
# 10.times do
#     name = Faker::Lorem.sentence(word_count: 20)
#     users.each { |user| user.courses.create!(name: name, 
#     course_category_id: en.id, picture: "default_img.png") } 
# end

# User.find(1).courses.each do |f| 
#     name = Faker::Lorem.sentence(word_count: 5)
#     f.lessons.create!(name: name,course_id: f.id, picture: "download.png")
# end

# User.find(1).courses[0].lessons[0].words.create!(word: "hello",meaning: "xin chao")
# User.find(1).courses[0].lessons.create!(name: "love and happy")
# User.find(1).courses[0].lessons[0].words << Word.new(word: "register",meaning: "dang ki", picture: "download.png") << Word.new(word: "plumber",meaning: "tho sua ong nuoc", picture: "download.png")<< Word.new(word: "hold",meaning: "to chuc", picture: "download.png")<< Word.new(word: "lover",meaning: "em yeu", picture: "download.png") << Word.new(word: "winter",meaning: "mua dong", picture: "download.png") << Word.new(word: "candidate",meaning: "ung vien", picture: "download.png")     
# Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 1, remember: true)
# Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 2, remember: false)
# Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 3, remember: false)
Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 4, remember: true)
Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 5, remember: true)
Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 6, remember: true)
Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 7, remember: true)
Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 8, remember: false)
