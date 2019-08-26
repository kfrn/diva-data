# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Film, type: :model do
  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:imdb_id) }
  end

  context "when the film doesn't have a cast" do
    film = FactoryBot.build(:film, actors: [])

    it 'is invalid' do
      expect(film.valid?).to be false
      expect(film.errors.full_messages).to include "Actors can't be blank"
    end
  end
end
