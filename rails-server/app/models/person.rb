# frozen_string_literal: true

class Person < ApplicationRecord
  validates :imdb_id, presence: true
  validates :name, presence: true
end
