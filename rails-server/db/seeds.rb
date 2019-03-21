# frozen_string_literal: true

require 'csv'

def upload_actors
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

def upload_countries
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

def upload_cities
  if City.none?
    cities = []

    CSV.foreach('../data/production_companies.csv', headers: true) do |row|
      next if row['city'].nil?

      production_cities = row['city'].split(', ')

      production_cities.map { |c| cities << c unless cities.include? c }
    end

    puts cities

    puts 'Importing cities to database ...'

    City.import(cities.map { |c| { name: c } })

    puts 'Done!'
  else
    puts 'The database already has cities in it! Please destroy all before attempting to seed.'
  end
end

def upload_production_companies
  if ProductionCompany.none?
    puts 'Reading in list of production companies ...'

    CSV.foreach('../data/production_companies.csv', headers: true) do |row|
      name = row['name'] if row['name']
      city = row['city'].split(', ') if row['city']
      cities = city&.map { |c| City.find_by(name: c) }
      country = Country.find_by(name: row['country']) if row['country']

      if cities
        puts "Creating production company: #{name}, #{cities.map(&:name).join(', ')}, #{country.name}"

        ProductionCompany.create(name: name, cities: cities, country: country)
      else
        puts "Creating production company: #{name}, #{country&.name}"

        ProductionCompany.create(name: name, country: country)
      end
    end

    puts 'Done!'
  else
    puts 'The database already has production companies in it! Please destroy all before attempting to seed.'
  end
end

upload_actors
indicate_divadom
set_as_director
upload_countries
upload_cities
upload_production_companies
