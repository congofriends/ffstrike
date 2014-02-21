FactoryGirl.define do
  factory :movement do
    name 'My Little Pony'
    tagline 'Lovely life of a lovely little pony.'
    video "http://www.youtube.com/watch?v=EpnERlsfBFc"
    user

    factory :published_movement do
      published true
    end

    factory :unpublished_movement do
      published false
    end
  end

  factory :nameless_movement, class: Movement do
    tagline 'I am an invalid movement because I have no name.'
    user
  end

  factory :movement_with_invalid_video, class: Movement do
    name 'My Little Pony'
    tagline 'Lovely life of a lovely little pony.'
    video "http://www.youtube.com/watch?v=EpnERlsfBFc<7878>"
    user
  end

  factory :movement_without_video, class: Movement do
    name 'My Little Pony'
    user
  end

end
