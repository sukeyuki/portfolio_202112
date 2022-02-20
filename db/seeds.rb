# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# user登録

user0 = User.new(
  name:"admin", 
  search_name:"admin",
  email:"admin@admin.com",
  password:Rails.application.credentials[:seed_admin_password],
  password_confirmation:Rails.application.credentials[:seed_admin_password]
)
user0.skip_confirmation!
user0.save!


user1 = User.new(
  name:"太郎", 
  search_name:"tarou",
  email:"tarou@tarou.com",
  password:Rails.application.credentials[:seed_user_password],
  password_confirmation:Rails.application.credentials[:seed_user_password]
)
user1.skip_confirmation!
user1.save!

user2 = User.new(
  name:"妻", 
  search_name:"tsuma",
  email:"tsuma@tsuma.com",
  password:Rails.application.credentials[:seed_user_password],
  password_confirmation:Rails.application.credentials[:seed_user_password]
)
user2.skip_confirmation!
user2.save

user3 = User.new(
  name:"息子", 
  search_name:"musuko",
  email:"musuko@musuko.com",
  password:Rails.application.credentials[:seed_user_password],
  password_confirmation:Rails.application.credentials[:seed_user_password]
)
user3.skip_confirmation!
user3.save

user4 = User.new(
  name:"同僚1", 
  search_name:"douryou1",
  email:"douryou1@douryou1.com",
  password:Rails.application.credentials[:seed_user_password],
  password_confirmation:Rails.application.credentials[:seed_user_password]
)
user4.skip_confirmation!
user4.save

user5 = User.new(
  name:"同僚2", 
  search_name:"douryou2",
  email:"douryou2@douryou2.com",
  password:Rails.application.credentials[:seed_user_password],
  password_confirmation:Rails.application.credentials[:seed_user_password]
)
user5.skip_confirmation!
user5.save

user6 = User.new(
  name:"部長", 
  search_name:"butyou",
  email:"butyou@butyou.com",
  password:Rails.application.credentials[:seed_user_password],
  password_confirmation:Rails.application.credentials[:seed_user_password]
)
user6.skip_confirmation!
user6.save

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
  name:"会社",
  overview:"会社のプロジェクト",
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
  user_id: user6.id,
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

group4 = user4.groups.create!(
  name:"登山仲間",
  overview:"登山の友達",
  personal:false,
)

GroupUser.find_by(group_id:group4.id, user_id:user4.id).update(activated:true, role:10)
GroupUser.create!(
  group_id: group4.id,
  user_id: user1.id,
  activated: true,
  role:20
)

100.times do |i|

  user1.groups.find_by(name:"private").schedules.create(
    title: "資料作成",
    contents: "会議に向けて資料を作成する。",
    start_at: Time.zone.parse("2022-02-2 13:00:00Z")+(7*60*60*24)*i,
    end_at: Time.zone.parse("2022-02-2 14:00:00Z")+(7*60*60*24)*i
  ) 

  user1.groups.find_by(name:"private").schedules.create(
    title: "筋トレ",
    contents: "ジムで筋肉トレーニング",
    start_at: Time.zone.parse("2022-02-1 19:00:00Z")+(7*60*60*24)*i,
    end_at: Time.zone.parse("2022-02-1 20:00:00Z")+(7*60*60*24)*i
  ) 

  if i%2 == 0
    group1.schedules.create(
      title: "家族で"+["温泉","海","北海道"][i%3]+"に旅行",
      contents: ["温泉","海","北海道"][i%3]+"に一泊二日旅行",
      start_at: Time.zone.parse("2022-02-5 06:00:00Z")+(7*60*60*24)*i,
      end_at: Time.zone.parse("2022-02-6 21:00:00Z")+(7*60*60*24)*i
    )
  else
    group3.schedules.create(
      title: "ゴルフ",
      contents: "コンペ",
      start_at: Time.zone.parse("2022-02-5T6:00:00Z")+(7*60*60*24)*i,
      end_at: Time.zone.parse("2022-02-6T21:00:00Z")+(7*60*60*24)*i
    )
  end


  group1.schedules.create(
    title: "家族で食事",
    contents: "夕食",
    start_at: Time.zone.parse("2022-02-2T18:00:00Z")+(7*60*60*24)*i,
    end_at: Time.zone.parse("2022-02-2T20:00:00Z")+(7*60*60*24)*i
  )

  group1.schedules.create(
    title: "家族で映画",
    contents: "家で映画鑑賞",
    start_at: Time.zone.parse("2022-02-3T18:00:00Z")+(7*60*60*24)*i,
    end_at: Time.zone.parse("2022-02-3T20:00:00Z")+(7*60*60*24)*i
  )

  5.times do |j|
    group2.schedules.create(
      title: "朝ミーティング",
      contents: "前日までの報告",
      start_at: Time.zone.parse("2022-01-31T9:00:00Z")+(60*60*24)*j+(7*60*60*24)*i,
      end_at: Time.zone.parse("2022-01-31T10:00:00Z")+(60*60*24)*j+(7*60*60*24)*i
    )

    group2.schedules.create(
      title: "第"+(j+1+i*5).to_s+"回進捗会議",
      contents: "プロジェクト会議",
      start_at: Time.zone.parse("2022-01-31T16:00:00Z")+(60*60*24)*j+(7*60*60*24)*i,
      end_at: Time.zone.parse("2022-01-31T17:00:00Z")+(60*60*24)*j+(7*60*60*24)*i
    )
  end

  group2.schedules.create(
    title: "飲み会",
    contents: "打ち上げ飲み会",
    start_at: Time.zone.parse("2022-02-2T19:00:00Z")+(7*60*60*24)*i,
    end_at: Time.zone.parse("2022-02-2T21:00:00Z")+(7*60*60*24)*i
  )

  group2.schedules.create(
    title: "飲み会",
    contents: "打ち上げ飲み会",
    start_at: Time.zone.parse("2022-02-4T19:00:00Z")+(7*60*60*24)*i,
    end_at: Time.zone.parse("2022-02-4T21:00:00Z")+(7*60*60*24)*i
  )


end
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