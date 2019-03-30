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

        expect(film['countries']).to be_instance_of Array
        film['countries'].each do |country|
          expect(country).to be_a String
          expect(country).not_to include('created_at')
          expect(country).not_to include('updated_at')
        end

        expect(film['directors']).to be_instance_of Array
        film['directors'].each do |director|
          expect(director['name']).to be_a String
          expect(director['imdb_id']).to be_a String
          expect(director).not_to include('created_at')
          expect(director).not_to include('updated_at')
        end

        expect(film['release_month']).to be_a String
        expect(film['release_year']).to be_a Integer
        expect(film['release_location']).to be_a String

        expect(film['production_companies']).to be_instance_of Array
        film['production_companies'].each do |company|
          expect(company['name']).to be_a String
          expect(company['cities']).to be_instance_of Array
          company['cities'].each do |city|
            expect(city).to be_a String
          end
          expect(company['country']).to be_a String

          expect(company).not_to include('created_at')
          expect(company).not_to include('updated_at')
        end


        expect(film['actors']).to be_instance_of Array
        film['actors'].each do |actor|
          expect(actor['name']).to be_a String
          expect(actor['imdb_id']).to be_a String
          expect(actor).not_to include('created_at')
          expect(actor).not_to include('updated_at')
        end

        expect(film['imdb_id']).to be_a String
        expect(film).not_to include('created_at')
        expect(film).not_to include('updated_at')
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
