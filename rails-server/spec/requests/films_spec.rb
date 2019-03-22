# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Films API', type: :request do
  let!(:films) { 10.times { FactoryBot.create(:film) } }

  describe 'GET /films' do
    before           { get '/films' }
    let(:films_json) { JSON.parse(response.body) }

    it 'returns the list of films' do
      expect(films_json).not_to be_empty
      expect(films_json.size).to eq(10)

      films_json.each do |film|
        expect(film['title']).to be_a String
        expect(film['year']).to be_a Integer
        expect(film['release_month']).to be_a String
        expect(film['release_year']).to be_a Integer
        expect(film['imdb_id']).to be_a String
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
