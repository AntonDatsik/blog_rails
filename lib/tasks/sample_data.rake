namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    99.times do |n|
      name  = Faker::Name.name
      password  = "password"
      User.create!(name: name,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 5)

    users.each do |user|
      50.times do |n|
        title = Faker::Lorem.sentence(1)
        body = Faker::Lorem.sentences(30)
        user.posts.create!(title: title, body: body.join)
      end
    end

    users = User.all(limit: 5)
    posts = Post.all(limit: 5)

    users.each do |user|
      posts.each do |post|
        post_id = post.id
        content = Faker::Lorem.sentences(10)
        user.comments.create!(post_id: post_id, content: content.join)
      end
    end

  end
end
