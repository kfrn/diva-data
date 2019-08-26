# frozen_string_literal: true

class Person < ApplicationRecord
  has_and_belongs_to_many :films

  validates_presence_of :name,
                        :imdb_id
end
