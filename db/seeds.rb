# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# user登録
user1 = User.new(
  name:"太郎", 
  search_name:"tarou",
  email:"tarou@tarou.com",
  password:123456789,
  password_confirmation:123456789
)
user1.skip_confirmation!
user1.save!

user2 = User.new(
  name:"母", 
  search_name:"hanako",
  email:"hanako@hanako.com",
  password:123456789,
  password_confirmation:123456789
)
user2.skip_confirmation!
user2.save

user3 = User.new(
  name:"息子", 
  search_name:"musuko",
  email:"musuko@musuko.com",
  password:123456789,
  password_confirmation:123456789
)
user3.skip_confirmation!
user3.save

user4 = User.new(
  name:"同僚1", 
  search_name:"douryou1",
  email:"douryou1@douryou1.com",
  password:123456789,
  password_confirmation:123456789
)
user4.skip_confirmation!
user4.save

user5 = User.new(
  name:"同僚2", 
  search_name:"douryou2",
  email:"douryou2@douryou2.com",
  password:123456789,
  password_confirmation:123456789
)
user5.skip_confirmation!
user5.save

# グループ登録
group1 = user1.groups.create!(
  name:"家族",
  overview:"楽しい家族",
  personal:false,
)
GroupUser.find_by(group_id:group1.id, user_id:user1.id).update(activated:true, role:10)
GroupUser.create!(
  group_id: group1.id,
  user_id: user2.id,
  activated: true,
  role: 20
)
GroupUser.create!(
  group_id: group1.id,
  user_id: user3.id,
  activated: true,
  role:20
)

group2 = user1.groups.create!(
  name:"会社仲間",
  overview:"会社の友達",
  personal:false,
)
GroupUser.find_by(group_id:group2.id, user_id:user1.id).update(activated:true, role:10)
GroupUser.create!(
  group_id: group2.id,
  user_id: user4.id,
  activated: true,
  role:20
)
GroupUser.create!(
  group_id: group2.id,
  user_id: user5.id,
  activated: true,
  role:20
)

group3 = user1.groups.create!(
  name:"ゴルフ仲間",
  overview:"ゴルフの友達",
  personal:false,
)
GroupUser.find_by(group_id:group3.id, user_id:user1.id).update(activated:true, role:10)
GroupUser.create!(
  group_id: group3.id,
  user_id: user4.id,
  activated: true,
  role:20
)

group1.schedules.create(
  title: "家族で旅行",
  contents: "熱海に旅行",
  start_at: "2022-02-1T06:00:00Z",
  end_at: "2022-02-2T21:00:00Z"
)

group1.schedules.create(
  title: "家族で食事",
  contents: "夕食",
  start_at: "2022-02-3T18:00:00Z",
  end_at: "2022-02-3T21:00:00Z"
)

group2.schedules.create(
  title: "飲み会",
  contents: "打ち上げ飲み会",
  start_at: "2022-02-3T18:00:00Z",
  end_at: "2022-02-3T21:00:00Z"
)

group3.schedules.create(
  title: "ゴルフ",
  contents: "コンペ",
  start_at: "2022-02-5T6:00:00Z",
  end_at: "2022-02-5T21:00:00Z"
)

# 5.times do |n|
#   group = user1.groups.create!(
#     name:"group#{n}",
#     overview:"group#{n}overview",
#     personal:false,
#   )
#   GroupUser.find_by(group_id:group.id, user_id:user1.id).update(activated:true)
#   GroupUser.create!(
#     group_id: group.id,
#     user_id: @user2.id,
#     activated: true
#   )

#   GroupUser.create!(
#     group_id: group.id,
#     user_id: @user3.id,
#     activated: true
#   )

#   GroupUser.create!(
#     group_id: group.id,
#     user_id: @user4.id
#   )
#   5.times do |n|
#     group.schedules.create(
#       title: "#{n}plan_name",
#       contents: "I have plans",
#       start_at: "2022-02-#{n+1}T06:00:00Z",
#       end_at: "2022-02-#{n+1}T07:00:00Z"
#     )
#   end
# end

user4group = user4.groups.create(
  name:"釣り仲間",
  overview:"楽しい釣りの会",
  personal:false
)
GroupUser.find_by(group_id:user4group.id, user_id:user4.id).update(activated:true, role:10)


user5group = user5.groups.create(
  name:"筋トレの会",
  overview:"楽しい筋トレの会",
  personal:false
)
GroupUser.find_by(group_id:user5group.id, user_id:user5.id).update(activated:true, role:10)


GroupUser.create!(
  group_id: user4group.id,
  user_id: user1.id,
)

GroupUser.create!(
  group_id: user5group.id,
  user_id: user1.id,
)