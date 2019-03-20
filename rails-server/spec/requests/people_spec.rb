# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'People API', type: :request do
  let!(:people)       { FactoryBot.create_list(:person, 10) }

  describe 'GET /people' do
    before            { get '/people' }
    let(:people_json) { JSON.parse(response.body) }

    it 'returns people' do
      expect(people_json).not_to be_empty
      expect(people_json.size).to eq(10)

      people_json.each do |person|
        expect(person['name']).to be_a String
        expect(person['imdb_id']).to be_a String
        expect(person['director']).to be_in([true, false])
        expect(person['diva']).to be_in([true, false])
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /person/:id' do
    before       { get "/people/#{id}" }
    let(:person) { JSON.parse(response.body) }

    context 'when the record exists' do
      let(:id)        { people.first.id }

      it 'returns the person' do
        expect(person).not_to be_empty
        expect(person['id']).to eq(id)
        expect(person['name']).to be_a String
        expect(person['imdb_id']).to be_a String
        expect(person['director']).to be_in([true, false])
        expect(person['diva']).to be_in([true, false])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        expect(person).to match({ 'message' => "Couldn't find Person with 'id'=#{id}" })
      end
    end
  end
end
