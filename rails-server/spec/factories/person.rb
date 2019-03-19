# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    imdb_id  { Faker::IDNumber.valid }
    name     { Faker::Name.unique.name }
    director { false }
    diva     { false }
  end
end
