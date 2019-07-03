# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Countries API', type: :request do
  let!(:countries) { FactoryBot.create_list(:country, 10) }

  describe 'GET /countries' do
    before               { get '/countries' }
    let(:countries_json) { JSON.parse(response.body) }

    it 'returns the list of people' do
      expect(countries_json).not_to be_empty
      expect(countries_json.size).to eq(10)

      countries_json.each do |country|
        expect(country['id']).to be_a Integer
        expect(country['name']).to be_a String
        expect(country).not_to include('created_at')
        expect(country).not_to include('updated_at')
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
