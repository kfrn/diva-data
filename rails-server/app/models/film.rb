# frozen_string_literal: true

class Film < ApplicationRecord
  has_many :countries
  has_many :directors, class_name: 'Person'
  has_one  :release_location, class_name: 'Country'
  has_many :production_companies
  has_many :actors, class_name: 'Person'

  validates :title, presence: true
  validates :year, presence: true
  validates :actors, presence: true
  validates :imdb_id, presence: true
end
