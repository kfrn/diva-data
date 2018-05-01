#!/usr/bin/env python3

import csv
import requests
from bs4 import BeautifulSoup


def construct_person_url(person_id):
    return f'http://www.imdb.com/name/{person_id}/'


def retrieve_person_name(person_id):
    person_url = construct_person_url(person_id)

    page = requests.get(person_url)
    soup = BeautifulSoup(page.content, 'html.parser')

    name = soup.find('span', {'itemprop': 'name'}).get_text()

    return {
        'imdb_id': person_id,
        'name': name
    }


def get_director_list():
    source_csv_path = './data/diva_film_data.csv'
    source_file = csv.reader(open(source_csv_path, 'r'))

    director_list = []

    next(source_file, None)  # skips the headers

    for row in source_file:
        director_column = row[3]
        split_directors = director_column.split(',')
        for item in split_directors:
            if len(item) != 0:
                director_list.append(item.strip())

    return list(set(director_list))


def get_actor_list():
    source_csv_path = './data/diva_film_data.csv'
    source_file = csv.reader(open(source_csv_path, 'r'))

    actor_list = []

    next(source_file, None)  # skips the headers

    for row in source_file:
        actor_column = row[8]
        split_actors = actor_column.split(',')
        for item in split_actors:
            if len(item) != 0:
                actor_list.append(item.strip())

    return list(set(actor_list))


def retrieve_names(id_list):
    names_and_ids = []

    for id in id_list:
        name_and_id = retrieve_person_name(id)
        print("name_and_id: ", name_and_id)
        names_and_ids.append(name_and_id)

    return names_and_ids


def write_data_to_csv(film_data, type):
    output_csv_path = f'./data/{type}_names.csv'
    output_file = open(output_csv_path, 'w')

    film_data_fieldnames = ['imdb_id', 'name']

    writer = csv.DictWriter(output_file, fieldnames=film_data_fieldnames)

    writer.writeheader()

    for row in film_data:
        print(f'Writing row: {row}')

        writer.writerow(row)

    output_file.close()


director_list = get_director_list()
director_name_data = retrieve_names(director_list)

write_data_to_csv(director_name_data, 'director')

actor_list = get_actor_list()
total_actors = len(actor_list)

all_actor_name_data = []
count = 1

for actor in actor_list:
    name_data = retrieve_person_name(actor)
    print(f'Person number {count} of {total_actors}.')
    print(f'Printing name_data for {actor}. Name data: {name_data}')
    all_actor_name_data.append(name_data)
    count += 1

print('About to write actor data out to CSV.')

write_data_to_csv(all_actor_name_data, 'actor')

print('Finished!')
