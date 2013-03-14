FactoryGirl.define do
  factory :expense do
    sequence(:description) {|n| "#{['BEEF','SHIRT','CAKE','CAFE'][n%4]} MOTORCYCLE" }
    sequence(:expense_date) {|n| "12-12-#{2000+(n%31)}" }
    sequence(:price) { |n| 10*(n+1) }
  end

  factory :tag do 
    sequence(:name) { |n| ['VEHICLE','RESTAURANT','CLOTHING','RECREATION','FOOD'][n%5] }
  end

  # factory :expense_with_tag, :parent => :pairing do
   

  # end

  factory :pairing do 
    association :expense, :factory => :expense
    association :tag, :factory => :tag
  end
end