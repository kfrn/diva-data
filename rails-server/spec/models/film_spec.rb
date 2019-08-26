# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Film, type: :model do
  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:imdb_id) }
  end

  context 'associations' do
    it { should have_many(:actors) }
    it { should have_many(:countries) }
    it { should have_many(:directors) }
    it { should have_many(:production_companies) }
    it { should have_one(:release_location) }
  end

  context "when the film doesn't have a cast" do
    film = FactoryBot.build(:film, actors: [])

    it 'is invalid' do
      expect(film.valid?).to be false
      expect(film.errors.full_messages).to include "Actors can't be blank"
    end
  end
end
