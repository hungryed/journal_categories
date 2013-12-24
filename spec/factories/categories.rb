FactoryGirl.define do
  factory :category do
    sequence(:name) {|n| "Special #{n} Category"}
  end
end
