# frozen_string_literal: true

class ProductionCompany < ApplicationRecord
  has_and_belongs_to_many :films
  has_many                :cities
  has_one                 :country

  validates :name, presence: true
end
