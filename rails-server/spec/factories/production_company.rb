# frozen_string_literal: true

FactoryBot.define do
  factory :production_company do
    name   { Faker::Space.company }
    cities { FactoryBot.build_list(:city, 2) }

    association :country, factory: :country
  end
end
