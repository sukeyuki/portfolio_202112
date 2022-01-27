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
user1.save!

@user2 = User.new(
  name:"jirou", 
  search_name:"jirou",
  email:"jirou@jirou.com",
  password:123456789,
  password_confirmation:123456789
)
@user2.skip_confirmation!
@user2.save

@user3 = User.new(
  name:"saburou", 
  search_name:"saburou",
  email:"saburou@saburou.com",
  password:123456789,
  password_confirmation:123456789
)
@user3.skip_confirmation!
@user3.save

@user4 = User.new(
  name:"shirou", 
  search_name:"shirou",
  email:"shirou@shirou.com",
  password:123456789,
  password_confirmation:123456789
)
@user4.skip_confirmation!
@user4.save


# private_group = user1.groups.create(
#   name:"private_group",
#   overview:"my private group",
#   personal:true
# )
# GroupUser.find_by(group_id:private_group.id, user_id:user1.id).update(activated:true)


5.times do |n|
  group = user1.groups.create!(
    name:"group#{n}",
    overview:"group#{n}overview",
    personal:false,
  )
  GroupUser.find_by(group_id:group.id, user_id:user1.id).update(activated:true)
  GroupUser.create!(
    group_id: group.id,
    user_id: @user2.id,
    activated: true
  )

  GroupUser.create!(
    group_id: group.id,
    user_id: @user3.id,
    activated: true
  )

  GroupUser.create!(
    group_id: group.id,
    user_id: @user4.id
  )
  5.times do |n|
    group.schedules.create(
      title: "#{n}plan_name",
      contents: "I have plans",
      start_at: "2022-02-#{n+1}T06:00:00Z",
      end_at: "2022-02-#{n+1}T07:00:00Z"
    )
  end
end

user2group = @user2.groups.create(
  name:"user2group",
  overview:"user2group overview",
  personal:false
)

user3group = @user3.groups.create(
  name:"user3group",
  overview:"user3group overview",
  personal:false
)

GroupUser.create!(
  group_id: user2group.id,
  user_id: user1.id,
)

GroupUser.create!(
  group_id: user3group.id,
  user_id: user1.id,
)



# 5.times do |n|
#   private_group.schedules.create(
#     title: "#{n}plan_name",
#     contents: "I have plans",
#     start_at: '2001-02-03T12:13:14Z',
#     end_at: '2001-02-03T12:13:14Z'
#   )
# end