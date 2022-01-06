# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.new(
  name:"tarou", 
  search_name:"tarou",
  email:"tarou@tarou.com",
  password:123456789,
  password_confirmation:123456789
)
user1.skip_confirmation!
user1.save

user2 = User.create!(
  name:"jirou", 
  search_name:"jirou",
  email:"jirou@jirou.com",
  password:123456789,
  password_confirmation:123456789
)

private_group = user1.groups.create(
  name:"private_group",
  overview:"aaaaa",
  personal:true
)

5.times do |n|
  user1.groups.create!(
    name:"group#{n}",
    overview:"aaaaa",
    personal:false
  )
end
5.times do |n|
  private_group.schedules.create(
    title: "#{n}plan_name",
    contents: "Ihaveplans",
    start_at: '2001-02-03T12:13:14Z',
    end_at: '2001-02-03T12:13:14Z'
  )
end