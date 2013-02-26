FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "user_#{n}@example.com"}                                                                     
    sequence(:name){|n| "user#{n}"}                                                                     
    password "anything"
    password_confirmation "anything"
    status "user"
  end
  factory :admin, class: User do
    sequence(:email){|n| "admin_#{n}@example.com"}
    sequence(:name){|n| "admin#{n}"}                                                                     
    password "anything"
    password_confirmation "anything"
    status "admin"
  end
  factory :editor, class: User do
    sequence(:email){|n| "editor_#{n}@example.com"}
    sequence(:name){|n| "editor#{n}"}                                                                     
    password "anything"
    password_confirmation "anything"
    status "editor"
  end

end
