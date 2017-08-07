#!/usr/bin/env python3

import requests
import re
from bs4 import BeautifulSoup
import pprint
pp = pprint.PrettyPrinter(indent=4)

example_id = "nm0096330"

def construct_actress_url(actress_id):
    return f"http://www.imdb.com/name/{actress_id}/"

# test_actress_url = construct_actress_url(example_id)
# print("test_actress_url is: ", test_actress_url)

def extract_imdb_title_id(url):
    return re.search("tt\d+", url).group()

def extract_imdb_name_id(url):
    return re.search("nm\d+", url).group()

def extract_film_ids(actress_url):
    page = requests.get(actress_url)
    soup = BeautifulSoup(page.content, 'html.parser')

    film_data = []

    for item in soup.find_all(class_='filmo-row'):
        link = item.find('a')['href']
        imdb_id = extract_imdb_title_id(link)
        film_data.append(imdb_id)

    return film_data

# film_ids = extract_film_ids(test_actress_url)
# print("film_ids are: ", film_ids)

def construct_film_url(film_id):
    return f"http://www.imdb.com/title/{film_id}/"

# film_urls = list(map(construct_film_url, film_ids))
# print("film_urls are: ", film_urls)

test_film_id = "tt0008252"

def construct_full_cast_link(film_id):
    return f"http://www.imdb.com/title/{film_id}/fullcredits"

test_cast_link = construct_full_cast_link(test_film_id)
# print("full cast link is: ", test_cast_link)

def extract_full_cast(full_cast_url):
    page = requests.get(full_cast_url)
    soup = BeautifulSoup(page.content, 'html.parser')

    cast = []

    cast_html = soup.findAll('td', {'class': 'itemprop'})

    for person in cast_html:
        link = person.find('a')['href']
        imdb_id = extract_imdb_name_id(link)
        name = person.find('span').get_text()

        cast_member = {
            'name': name,
            'imdb_id': imdb_id
        }

        # print("cast_member info is: ", cast_member)
        cast.append(cast_member)

    return cast

full_cast_data = extract_full_cast(test_cast_link)
print("full_cast_data is: ", full_cast_data)
