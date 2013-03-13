FactoryGirl.define do
  factory :expense do
    description 'MOTORCYCLE'
    expense_date '12-12-2012'
    price 9000
  end

  factory :tag do 
    name 'VEHICLE'
  end

  factory :pairing do 
    association :expense, :factory => :expense
    association :tag, :factory => :tag
  end
end