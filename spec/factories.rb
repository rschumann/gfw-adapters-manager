FactoryGirl.define do

  sequence(:id)       { |n| "#{n+2}"                               }
  sequence(:user_id)  { |n| "#{n+2}"                               }
  sequence(:email)    { |n| "person-#{n}@example.com"              }
  sequence(:username) { |n| Faker::Internet.user_name("User_#{n}") }

  # Users #
  factory :user, class: User do
    id
    email
    firstname 'Random Guest'
    lastname  'User'
    password  'password'
    password_confirmation {|u| u.password}
    username
  end

  factory :admin_user, class: User do
    id
    firstname 'Pepe'
    lastname  'Moreno'
    email     'pepe-moreno@sample.com'
    password  'password'
    password_confirmation { |u| u.password }
    username
    after(:create) do |user|
      FactoryGirl.create(:admin, user: user)
    end
  end

  factory :admin, class: AdminUser do
    user_id
  end
end