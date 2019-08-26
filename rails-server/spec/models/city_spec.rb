# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  context 'associations' do
    it { should belong_to(:production_company) }
  end
end
