# frozen_string_literal: true

FactoryBot.define do
  factory :film do
    title                { Faker::Book.title }
    year                 { Faker::Date.backward(50000).year }
    countries            { FactoryBot.build_list(:country, 2) }
    directors            { [ FactoryBot.build(:person, director: true) ] }
    release_month        { Faker::Date.backward(50000).strftime("%B") }
    release_year         { Faker::Date.backward(50000).year }
    production_companies { FactoryBot.build_list(:production_company, 2) }
    actors               { FactoryBot.build_list(:person, 8) }
    imdb_id              { Faker::IDNumber.valid }

    association :release_location, factory: :country
  end
end
