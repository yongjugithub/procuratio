# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Employee.create(
  employee_id: 1,
  name: "admin user",
  password: "admin",
  password_confirmation: "admin",
  admin: true
)
21.times do |n|
  Employee.create(
    employee_id: n + 101,
    name: "サンプルユーザー#{n + 1}",
    password: "password",
    password_confirmation: "password"
  )
end
Attendance.create(
  employee_id: 2,
  point: 10
)
21.times do |n|
  Attendance.create(
    employee_id: 2,
    point: 10
  )
end
