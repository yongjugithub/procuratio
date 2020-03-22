FactoryBot.define do
  factory :employee do
    employee_id { 1 }
    name { 'test user' }
    password { 'password' }
    password_confirmation { 'pasword' }
  end
end
