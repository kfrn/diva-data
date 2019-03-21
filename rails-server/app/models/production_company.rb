# frozen_string_literal: true

class ProductionCompany < ApplicationRecord
  has_many :cities
  has_one :country

  validates :name, presence: true
end
