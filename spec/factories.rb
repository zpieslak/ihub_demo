FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :group do
    name 'group name'
  end

  factory :contact do
    name 'contact name'
    email 'test@test.com'
    phone '123456789'
  end
end
