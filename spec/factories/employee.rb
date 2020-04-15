FactoryBot.define do
  factory :employee do
    employee_id { 1 }
    name { 'non_admin' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
