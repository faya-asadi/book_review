FactoryBot.define do
  #factory :user do
  #  username {"user name"}
  #  email {"user@user.com"}
  #  password {"1234"}
  #end

factory :user do
  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:username) {|n|"user name#{n}"}
  sequence(:password) {|n| "1234#{n}"}
end

end
