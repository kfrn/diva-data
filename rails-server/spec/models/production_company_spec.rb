# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductionCompany, type: :model do
  context 'when a ProductionCompany has all attributes' do
    it 'is valid' do
      company = FactoryBot.build(:production_company)

      expect(company.valid?).to be true
    end
  end

  context "when a ProductionCompany doesn't have a city" do
    it 'is valid' do
      company = FactoryBot.build(:production_company, cities: [])

      expect(company.valid?).to be true
    end
  end

  context "when a ProductionCompany doesn't have a country" do
    it 'is valid' do
      company = FactoryBot.build(:production_company, country: nil)

      expect(company.valid?).to be true
    end
  end

  context "when a ProductionCompany doesn't have a name" do
    it 'is invalid' do
      company = ProductionCompany.new.valid?

      expect(company).to be false
    end
  end
end
