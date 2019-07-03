# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  context 'when a Person has all attributes' do
    it 'is valid' do
      expect(FactoryBot.build(:person).valid?).to be true
    end
  end

  context 'when a Person has only an IMDb ID' do
    it 'is invalid' do
      person = FactoryBot.build(:person, name: nil)

      expect(person.valid?).to be false
    end
  end

  context 'when a Person has only a name' do
    it 'is invalid' do
      person = FactoryBot.build(:person, imdb_id: nil)

      expect(person.valid?).to be false
    end
  end

  context 'when a Person has neither an IMDb ID and a name' do
    it 'is invalid' do
      expect(Person.new.valid?).to be false
    end
  end
end
