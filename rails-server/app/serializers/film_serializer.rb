# frozen_string_literal: true

class FilmSerializer < ActiveModel::Serializer
  attributes :id, :title, :year, :countries, :directors, :release_month,
             :release_year, :release_location, :production_companies, :actors,
             :imdb_id

  def countries
    object.countries.map(&:name)
  end

  def directors
    object.directors.map { |d| { name: d.name, imdb_id: d.imdb_id } }
  end

  def release_location
    object.release_location&.name
  end

  def production_companies
    object.production_companies.map do |c|
      {
        name: c.name,
        cities: c.cities.map(&:name),
        country: c.country&.name
      }
    end
  end

  def actors
    object.actors.map { |a| { name: a.name, imdb_id: a.imdb_id } }
  end
end
