# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Film, type: :model do
  context 'when a film has all attributes' do
    it 'is valid' do
      film = FactoryBot.build(:film)

      expect(film.valid?).to be true
    end
  end

  context "when the film doesn't have a title" do
    film = FactoryBot.build(:film, title: nil)

    it 'is invalid' do
      expect(film.valid?).to be false
      expect(film.errors.full_messages).to include "Title can't be blank"
    end
  end

  context "when the film doesn't have a year" do
    film = FactoryBot.build(:film, year: nil)

    it 'is invalid' do
      expect(film.valid?).to be false
      expect(film.errors.full_messages).to include "Year can't be blank"
    end
  end

  context "when the film doesn't have a cast" do
    film = FactoryBot.build(:film, actors: [])

    it 'is invalid' do
      expect(film.valid?).to be false
      expect(film.errors.full_messages).to include "Actors can't be blank"
    end
  end

  context "when the film doesn't have an IMDb ID" do
    film = FactoryBot.build(:film, imdb_id: nil)

    it 'is invalid' do
      expect(film.valid?).to be false
      expect(film.errors.full_messages).to include "Imdb can't be blank"
    end
  end
end
