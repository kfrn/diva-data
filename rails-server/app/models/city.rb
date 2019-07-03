# frozen_string_literal: true

class City < ApplicationRecord
  belongs_to :production_company

  validates :name, presence: true
end
