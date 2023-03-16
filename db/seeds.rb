# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(name: "管理者A", email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
movie_state_name = ["見た", "見たい", "途中", "断念"]
4.times do |i|
  MovieStateName.create!(
    id: i + 1,
    name: movie_state_name[i]
    )
end