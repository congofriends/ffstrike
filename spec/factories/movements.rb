# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movement do
    name 'My Little Pony'
    category 'Ponies'
    story 'Lovely life of a lovely little pony.'
  end

  factory :nameless_movement, class: Movement do
    story 'I am an invalid movement because I have no name.'
  end
end
