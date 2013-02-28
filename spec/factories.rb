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
  factory :entry do
    users [FactoryGirl.create(:editor)]
    sequence(:wadoku_id){|n| n}
    sequence(:midashigo){|n| "midashigo#{n}"}
    sequence(:kana){|n| "kana#{n}"}
    sequence(:writing){|n| "writing#{n}"}
    sequence(:romaji){|n| "romaji#{n}"}
    sequence(:definition){|n| "definition#{n}"}
    sub_entry "sub_entry"
  end 

end
