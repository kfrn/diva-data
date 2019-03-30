# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Directors API', type: :request do
  let!(:directors) { 10.times { FactoryBot.create(:person, director: true) } }

  describe 'GET /directors' do
    before               { get '/directors' }
    let(:directors_json) { JSON.parse(response.body) }

    it 'returns the list of directors' do
      expect(directors_json).not_to be_empty
      expect(directors_json.size).to eq(10)

      directors_json.each do |director|
        expect(director['name']).to be_a String
        expect(director['imdb_id']).to be_a String
        expect(director['diva']).to be_in([true, false])
        expect(director['director']).to be true
        expect(director).not_to include('created_at')
        expect(director).not_to include('updated_at')
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
