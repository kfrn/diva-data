# frozen_string_literal: true

class Country < ApplicationRecord
  validates :name, presence: true
end
