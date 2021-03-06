FactoryBot.define do
  factory :book do
    association :user, factory: :user, strategy: :build
    sequence(:title) {|n| "Title#{n}"}
    author {"Author"}  

    after(:build) do |book|
      book.user = FactoryBot.create(:user)
    end
  end
end
