# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Divas API', type: :request do
  let!(:divas) { 10.times { FactoryBot.create(:person, diva: true) } }

  describe 'GET /divas' do
    before           { get '/divas' }
    let(:divas_json) { JSON.parse(response.body) }

    it 'returns the list of divas' do
      expect(divas_json).not_to be_empty
      expect(divas_json.size).to eq(10)

      divas_json.each do |diva|
        expect(diva['name']).to be_a String
        expect(diva['imdb_id']).to be_a String
        expect(diva['director']).to be_in([true, false])
        expect(diva['diva']).to be true
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
