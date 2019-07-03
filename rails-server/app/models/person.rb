# frozen_string_literal: true

class Person < ApplicationRecord
  has_and_belongs_to_many :films

  validates :imdb_id, presence: true
  validates :name, presence: true
end
