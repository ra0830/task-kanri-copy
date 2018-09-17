100.times do |n|
  title = Faker::Pokemon.name
  content = Faker::Pokemon.name
  Task.create!(title: title,
               content: content,
               )
end
