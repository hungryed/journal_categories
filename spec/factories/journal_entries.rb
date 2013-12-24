FactoryGirl.define do
  factory :journal_entry do
    sequence(:title) {|n| "My #{n} Post"}
    sequence(:description) {|n| "Good #{n} stuff here"}
  end
end
