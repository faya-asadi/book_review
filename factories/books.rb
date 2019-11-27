FactoryBot.define do
  factory :book do
    sequence(:title) {|n| "Title#{n}"}
    author {"Author"}
    user_id {1}
  end
end
