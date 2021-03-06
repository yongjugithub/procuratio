# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 関連テーブルの作成は紐づくモデルのIDの変更に注意すること
# 本番環境のMYSQLではIDが連番ではなく10ごとに飛ぶため文法エラーに注意
Employee.create!(
  employee_id: 1,
  name: "管理者サンプルユーザー",
  password: "admin",
  password_confirmation: "admin",
  admin: true
)
21.times do |n|
  Employee.create!(
    employee_id: n + 102,
    name: "サンプルユーザー#{n + 2}",
    password: "password",
    password_confirmation: "password"
  )
end
Attendance.create!(
  employee_id: 1,
  point: 0
)
21.times do |n|
  Attendance.create!(
    employee_id: 1,
    ride_in: "東京駅 ~ 渋谷",
    attr_one: true,
    attr_two: true,
    attr_three: true,
    attr_four: true,
    attr_five: true,
    attr_six: true,
    attr_seven: true,
    attr_eight: true,
    attr_nine: true,
    attr_ten: true,
    point: 10
  )
end
