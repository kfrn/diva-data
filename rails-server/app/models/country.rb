# frozen_string_literal: true

class Country < ApplicationRecord
  has_and_belongs_to_many :film
  has_and_belongs_to_many :production_company

  validates :name, presence: true
end
