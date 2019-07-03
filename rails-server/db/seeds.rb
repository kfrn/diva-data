# frozen_string_literal: true

require 'csv'

def import_actors
  if Person.none?
    puts 'Reading in list of actors ...'

    actors = []

    CSV.foreach('../data/actor_names.csv', headers: true) do |row|
      actors << Person.new(row.to_h)
    end

    puts 'Importing actors to database ...'

    Person.import(actors)

    puts 'Done!'
  else
    puts 'The database already has people in it! Please destroy all before attempting to seed.'
  end
end

def indicate_divadom
  puts 'Reading in list of divas ...'

  CSV.foreach('../data/diva_ids.csv', headers: false) do |row|
    name = row[0]
    imdb_id = row[1]

    diva = Person.find_by(imdb_id: imdb_id)
    diva.update(diva: true)

    puts "#{name} set as diva."
  end
end

def set_as_director
  puts 'Reading in list of directors ...'

  directors = []

  CSV.foreach('../data/director_names.csv', headers: true) do |row|
    director = Person.find_by(imdb_id: row['imdb_id'])

    if director
      puts "Updating existing record for #{director.name}"

      director.update(director: true)
    else
      directors << Person.new(row.to_h)
    end
  end

  puts 'Importing directors to database ...'

  Person.import(directors)

  puts 'Done!'
end

def import_countries
  if Country.none?
    puts 'Reading in list of countries ...'

    countries = []

    CSV.foreach('../data/diva_film_data.csv', headers: true) do |row|
      production_countries = row['production_country'].split(', ')
      production_countries.map { |c| countries << c unless countries.include? c }

      release_location = row['release_location']
      countries << release_location unless countries.include? release_location || release_location.nil?
    end

    CSV.foreach('../data/production_companies.csv', headers: true) do |row|
      country = row['country']

      countries << country unless countries.include? country || country.nil?
    end

    puts 'Importing countries to database ...'

    Country.import(countries.map { |c| { name: c } })

    puts 'Done!'
  else
    puts 'The database already has countries in it! Please destroy all before attempting to seed.'
  end
end

def import_cities
  if City.none?
    cities = []

    CSV.foreach('../data/production_companies.csv', headers: true) do |row|
      next if row['city'].nil?

      production_cities = row['city'].split(', ')

      production_cities.map { |c| cities << c unless cities.include? c }
    end

    puts 'Importing cities ...'

    City.import(cities.map { |c| { name: c } })

    puts 'Done!'
  else
    puts 'The database already has cities in it! Please destroy all before attempting to seed.'
  end
end

def import_production_companies
  if ProductionCompany.none?
    puts 'Reading in list of production companies ...'

    if Country.none? || City.none?
      puts "ALERT! Something's gone wrong: there are no countries or cities in the database."
    end

    CSV.foreach('../data/production_companies.csv', headers: true) do |row|
      name = row['name'] if row['name']
      city_names = row['city']&.split(', ') || []
      cities = city_names.map { |c| City.find_by(name: c) }
      country = Country.find_by(name: row['country']) if row['country']

      puts "Creating production company: #{name}"

      ProductionCompany.create(name: name, cities: cities, country: country)
    end

    puts 'Done!'
  else
    puts 'The database already has production companies in it! Please destroy all before attempting to seed.'
  end
end

def import_films
  if Film.none?
    puts 'Reading in list of films ...'

    if Country.none? || City.none?
      puts "ALERT! Something's gone wrong: there are no countries or cities in the database."
    elsif Person.none?
      puts "ALERT! Something's gone wrong: there are no people in the database."
    elsif ProductionCompany.none?
      puts "ALERT! Something's gone wrong: there are no production companies in the database."
    end

    count = 0

    CSV.foreach('../data/diva_film_data.csv', headers: true) do |row|
      title = row['film_title']
      year = row['film_year']
      release_month = row['release_month']
      release_year = row['release_year']
      release_location_name = row['release_location']
      imdb_id = row['imdb_id']

      country_names = row['production_country']&.split(', ') || []
      countries = country_names&.map { |c| Country.find_by(name: c) }

      director_ids = row['director']&.split(', ') || []
      directors = director_ids&.map { |id| Person.find_by(imdb_id: id) }

      production_company_names = row['production_company']&.split(', ') || []
      production_companies = production_company_names&.map { |name| ProductionCompany.find_by(name: name) }

      cast_ids = row['cast']&.split(', ') || []
      actors = cast_ids&.map { |id| Person.find_by(imdb_id: id) }

      Film.create(
        title: title,
        year: year,
        countries: countries,
        directors: directors,
        release_month: release_month,
        release_year: release_year,
        release_location: Country.find_by(name: release_location_name),
        production_companies: production_companies,
        actors: actors,
        imdb_id: imdb_id
      )

      print '.'

      count += 1
    end

    puts "Done! #{count} films imported."
  else
    puts 'The database already has films in it! Please destroy all before attempting to seed.'
  end
end

import_actors
indicate_divadom
set_as_director
import_countries
import_cities
import_production_companies
import_films
