# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Country, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  context 'associations' do
    # it { should have_and_belong_to_many(:films) }
    # it { should have_and_belong_to_many(:production_company) }
  end
end
