# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductionCompany, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  context 'associations' do
    it { should have_many(:cities) }
    it { should have_one(:country) }
    # it { should have_and_belong_to_many(:films) }
  end
end
