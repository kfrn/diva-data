# frozen_string_literal: true

class City < ApplicationRecord
  belongs_to :production_company

  validates_presence_of :name
end
