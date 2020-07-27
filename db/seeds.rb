# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# # #   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "thanhan",
    email: "nguyenthanhan1181999@gmail.com",
    password: "123456", 
    password_confirmation: "123456",
    activated: true,
    isAdmin: true,
    activated_at: Time.zone.now)
User.create!(name: "thuthuy",
    email: "thuthuy@gmail.com",
    password: "123456", 
    password_confirmation: "123456", 
    activated: true,
    activated_at: Time.zone.now)

# # add type of course
CourseCategory.create!(name: "English")
CourseCategory.create!(name: "Japanese")
# #add user
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
# #add course
en= CourseCategory.find(1)
jp= CourseCategory.find(2)

# # users = User.order(:created_at).take(6)
user1 = User.where('email=?',"nguyenthanhan1181999@gmail.com")[0]
user2 = User.where('email=?',"thuthuy@gmail.com")[0]
3.times do
    name = Faker::Lorem.sentence(word_count: 5)
    user1.courses.create!(name: name, 
    course_category_id: en.id, picture: "default_img.png") 
end
4.times do
    name = Faker::Lorem.sentence(word_count: 5)
    user2.courses.create!(name: name, 
    course_category_id: jp.id, picture: "default_img.png") 
end

user1.courses[0].lessons.create!(name: "greeting", picture: "download.png")
@lesson = user1.courses[0].lessons[0]
@word = Word.new(word: "hello",meaning:"xin chao",picture:"default_img.png",course_category_id: en.id)
@lesson.words << @word
@word1 = Word.new(word: "nice to meet you",meaning:"rat vui duoc gap",picture:"default_img.png",course_category_id: en.id)
@lesson.words << @word1
@word2 = Word.new(word: "see you again",meaning:"hen gap lai",picture:"default_img.png",course_category_id: en.id)
@lesson.words << @word2
@word3 = Word.new(word: "happy",meaning:"vui mung",picture:"default_img.png",course_category_id: en.id)
@lesson.words << @word3
@word4 = Word.new(word: "speak",meaning:"noi",picture:"default_img.png",course_category_id: en.id)
@lesson.words << @word4
@word5 = Word.new(word: "run",meaning:"chay",picture:"default_img.png",course_category_id: en.id)
@lesson.words << @word5
@word6 = Word.new(word: "think",meaning:"suy nghi",picture:"default_img.png",course_category_id: en.id)
@lesson.words << @word6
@word7 = Word.new(word: "touch",meaning:"cham",picture:"default_img.png",course_category_id: en.id)
@lesson.words << @word7
@word8 = Word.new(word: "hurt",meaning:"dau",picture:"default_img.png",course_category_id: en.id)
@lesson.words << @word8
@word9 = Word.new(word: "confortable",meaning:"thoai mai",picture:"default_img.png",course_category_id: en.id)
@lesson.words << @word9
@word10 = Word.new(word: "nervous",meaning:"lo lang",picture:"default_img.png",course_category_id: en.id)
@lesson.words << @word10

Study.new(user_id: 1,word_id:1).save
Study.new(user_id: 1,word_id:2).save
Study.new(user_id: 1,word_id:3).save
Study.new(user_id: 1,word_id:4).save
Study.new(user_id: 1,word_id:5).save
Study.new(user_id: 1,word_id:6).save
Study.new(user_id: 1,word_id:7).save
Study.new(user_id: 1,word_id:8).save
Study.new(user_id: 1,word_id:9).save
Study.new(user_id: 1,word_id:10).save

Study.new(user_id: 2,word_id:1).save
Study.new(user_id: 2,word_id:2).save
Study.new(user_id: 2,word_id:3).save
Study.new(user_id: 2,word_id:4).save
Study.new(user_id: 2,word_id:5).save
Study.new(user_id: 2,word_id:6).save
Study.new(user_id: 2,word_id:7).save
Study.new(user_id: 2,word_id:8).save
Study.new(user_id: 2,word_id:9).save

Study.new(user_id: 3,word_id:1).save
Study.new(user_id: 3,word_id:2).save
Study.new(user_id: 3,word_id:3).save
Study.new(user_id: 3,word_id:4).save
Study.new(user_id: 3,word_id:5).save
Study.new(user_id: 3,word_id:6).save
Study.new(user_id: 3,word_id:7).save
Study.new(user_id: 3,word_id:8).save

Study.new(user_id: 4,word_id:1).save
Study.new(user_id: 4,word_id:2).save
Study.new(user_id: 4,word_id:3).save
Study.new(user_id: 4,word_id:4).save
Study.new(user_id: 4,word_id:5).save
Study.new(user_id: 4,word_id:6).save
Study.new(user_id: 4,word_id:7).save

Study.new(user_id: 5,word_id:1).save
Study.new(user_id: 5,word_id:2).save
Study.new(user_id: 5,word_id:3).save
Study.new(user_id: 5,word_id:4).save
Study.new(user_id: 5,word_id:5).save
Study.new(user_id: 5,word_id:6).save

Study.new(user_id: 6,word_id:1).save
Study.new(user_id: 6,word_id:2).save
Study.new(user_id: 6,word_id:3).save
Study.new(user_id: 6,word_id:4).save
Study.new(user_id: 6,word_id:5).save

Study.new(user_id: 7,word_id:1).save
Study.new(user_id: 7,word_id:2).save
Study.new(user_id: 7,word_id:3).save
Study.new(user_id: 7,word_id:4).save

Study.new(user_id: 8,word_id:1).save
Study.new(user_id: 8,word_id:2).save
Study.new(user_id: 8,word_id:3).save

Study.new(user_id: 9,word_id:1).save
Study.new(user_id: 9,word_id:2).save

Study.new(user_id: 10,word_id:1).save







# User.find(1).courses[0].lessons[0].words.create!(word: "hello",meaning: "xin chao")
# User.find(1).courses[0].lessons.create!(name: "love and happy")
# User.find(1).courses[0].lessons[0].words << Word.create!(word: "register",meaning: "dang ki", picture: "download.png") 
# User.find(1).courses[0].lessons[0].words << Word.create!(word: "plumber",meaning: "tho sua ong nuoc", picture: "download.png")
# User.find(1).courses[0].lessons[0].words << Word.create!(word: "hold",meaning: "to chuc", picture: "download.png")
# User.find(1).courses[0].lessons[0].words << Word.create!(word: "lover",meaning: "em yeu", picture: "download.png") 
# User.find(1).courses[0].lessons[0].words << Word.create!(word: "winter",meaning: "mua dong", picture: "download.png") 
# User.find(1).courses[0].lessons[0].words << Word.create!(word: "candidate",meaning: "ung vien", picture: "download.png")     
# Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 1, remember: true)
# Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 2, remember: false)
# Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 3, remember: false)
# Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 4, remember: true)
# Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 5, remember: true)
# Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 6, remember: true)
# Study.create!(user_id: 1, course_id: 1, lesson_id: 1, word_id: 7, remember: true)
