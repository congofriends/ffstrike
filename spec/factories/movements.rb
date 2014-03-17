FactoryGirl.define do
  factory :movement do
    name {Faker::Lorem.words.join(' ')}
    tagline {Faker::Lorem.sentence}
    video "http://www.youtube.com/watch?v=EpnERlsfBFc"
    about_creator {Faker::Lorem.sentence}

    factory :published_movement do
      published true
    end

    factory :unpublished_movement do
      published false
    end
  end

  factory :nameless_movement, class: Movement do
    tagline {Faker::Lorem.sentence}
  end

  factory :movement_with_invalid_video, class: Movement do
    name {Faker::Lorem.words.join(' ')}
    tagline {Faker::Lorem.sentence}
    video "http://www.youtube.com/watch?v=EpnERlsfBFc<7878>"
  end

  factory :movement_without_video, class: Movement do
    name {Faker::Lorem.words.join(' ')}
  end

end
