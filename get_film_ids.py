#!/usr/bin/env python3

import csv
import json
import re
import requests
from bs4 import BeautifulSoup


def construct_actress_url(actress_id):
    return f'http://www.imdb.com/name/{actress_id}/'


def extract_imdb_title_id(url):
    return re.search('tt\d+', url).group()


def extract_film_ids(actress_url):
    page = requests.get(actress_url)
    soup = BeautifulSoup(page.content, 'html.parser')

    film_data = []

    for item in soup.find_all(class_='filmo-row'):
        film_title = item.find('a').get_text()
        film_link = item.find('a')['href']
        imdb_id = extract_imdb_title_id(film_link)

        film_data.append(imdb_id)

    return film_data


def extract_info(input_csv_path, output_csv_path):
    input_file = csv.reader(open(input_csv_path, 'r'))
    output_file = csv.writer(open(output_csv_path, 'w'))

    for row in input_file:
        imdb_id = row[1]

        actress_url = construct_actress_url(imdb_id)

        film_ids = extract_film_ids(actress_url)
        film_ids_as_string = ', '.join(film_ids)

        row.append(film_ids_as_string)
        output_file.writerow(row)


extract_info('./data/diva_ids.csv', './data/diva_film_ids.csv')
