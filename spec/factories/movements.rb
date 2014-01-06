FactoryGirl.define do
  factory :movement do
    name 'My Little Pony'
    category 'Ponies'
    story 'Lovely life of a lovely little pony.'
    video "http://www.youtube.com/watch?v=EpnERlsfBFc"
  end

  factory :nameless_movement, class: Movement do
    story 'I am an invalid movement because I have no name.'
  end

  factory :movement_with_invalid_video, class: Movement do
    name 'My Little Pony'
    category 'Ponies'
    story 'Lovely life of a lovely little pony.'
    video "http://www.youtube.com/watch?v=EpnERlsfBFc<7878>"
  end

  factory :movement_without_video, class: Movement do
    name 'My Little Pony'
  end
end
