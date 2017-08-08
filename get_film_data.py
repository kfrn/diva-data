#!/usr/bin/env python3

import csv
import re
import requests
from bs4 import BeautifulSoup


def extract_imdb_name_id(url):
    return re.search('nm\d+', url).group()


def construct_full_cast_link(film_id):
    return f'http://www.imdb.com/title/{film_id}/fullcredits'


def extract_full_cast(full_cast_url):
    page = requests.get(full_cast_url)
    soup = BeautifulSoup(page.content, 'html.parser')

    cast = []
    cast_html = soup.findAll('td', {'class': 'itemprop'})

    for person in cast_html:
        link = person.find('a')['href']
        imdb_id = extract_imdb_name_id(link)
        cast.append(imdb_id)

    return cast


def construct_main_page_link(film_id):
    return f'http://www.imdb.com/title/{film_id}'


def extract_film_name_and_year(html):
    film_name_with_year = html.find('h1', {'itemprop': 'name'}).get_text()
    film_name = re.search('([A-z\'\'\.]+)', film_name_with_year).group()
    film_year = re.search('(\d{4})', film_name_with_year).group()

    return {
        'name': film_name,
        'year': film_year
    }


def extract_director(html):
    director_html = html.findAll('span', {'itemprop': 'director'})

    directors = []
    for person in director_html:
        director_link = person.find('a')['href']
        director_id = re.search('(nm\d+)', director_link).group().strip()
        directors.append(director_id)

    return directors


def extract_release_date(html):
    title_text = 'See more release dates'
    date_and_place = html.find('a', {'title': title_text}).get_text().strip()
    month = re.search('([A-z]+)', date_and_place).group(0)
    year = re.search('(\d{4})', date_and_place).group()
    place = re.search('\((.*?)\)', date_and_place).group(1)

    return {
        'release_month': month,
        'release_year': year,
        'release_location': place
    }


def extract_production_company(html):
    itemtype = 'http://schema.org/Organization'
    companies_html = html.findAll('span', {'itemtype': itemtype})

    companies = []
    for item in companies_html:
        plain_name = item.get_text().strip()
        companies.append(plain_name)

    return companies


def extract_basic_info(main_page_url):
    page = requests.get(main_page_url)
    soup = BeautifulSoup(page.content, 'html.parser')

    film_name_and_year = extract_film_name_and_year(soup)
    director = extract_director(soup)
    release_date = extract_release_date(soup)
    production_company = extract_production_company(soup)

    return {
        'film_title': film_name_and_year['name'],
        'film_year': film_name_and_year['year'],
        'director': director,
        'release_month': release_date['release_month'],
        'release_year': release_date['release_year'],
        'release_location': release_date['release_location'],
        'production_company': production_company
    }


def extract_film_data(film_id):
    main_page_link = construct_main_page_link(film_id)
    film_information = extract_basic_info(main_page_link)

    full_cast_link = construct_full_cast_link(film_id)
    full_cast = extract_full_cast(full_cast_link)

    film_information['cast'] = full_cast

    return film_information


def stringify_values(dict):
    for key in dict:
        if isinstance(dict[key], list):
            list_as_string = ', '.join(dict[key])
            dict[key] = list_as_string

    return dict


def write_data_to_csv(film_data):
    output_csv_path = './data/diva_film_data.csv'
    output_file = open(output_csv_path, 'w')

    film_data_fieldnames = list(film_data[0].keys())

    writer = csv.DictWriter(output_file, fieldnames=film_data_fieldnames)

    writer.writeheader()

    for row in film_data:
        csv_data = stringify_values(row)
        print("csv_data: ", csv_data)

        writer.writerow(csv_data)

    output_file.close()


test_film_id = 'tt0002130'
# test_film_id = 'tt0008252'

film_data = extract_film_data(test_film_id)
film_data_list = [film_data]  # hack
write_data_to_csv(film_data_list)
