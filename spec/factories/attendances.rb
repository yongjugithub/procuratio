FactoryBot.define do
  factory :attendance do
    association :employee
    ride_at { '2020-03-29 10:25:02' }
    ride_in { 'MyText' }
    attr_one { false }
    attr_two { false }
    attr_three { false }
    attr_four { false }
    attr_five { false }
    attr_six { false }
    attr_seven { false }
    attr_eight { false }
    attr_nine { false }
    attr_ten { false }
    attr_eleven { false }
    attr_twelve { false }
    memo { 'MyText' }
    point { 1 }
  end
end
