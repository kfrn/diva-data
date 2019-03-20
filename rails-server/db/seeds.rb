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

upload_actors
indicate_divadom
set_as_director
