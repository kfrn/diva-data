# API Reference

As the dataset is static, the API only supports GET requests.

* [People](#people)
* [Divas](#divas)
* [Directors](#directors)
* [Countries](#countries)
* [Films](#films)

## People

| Method | Endpoint | Usage |
| ------ | -------- | ----- |
| GET | `/people` | Get list of all people represented in the dataset |

### Success

If the request is successful, the response will be a **200**, with the body:

```json
[
  {
    "id": 1,
    "imdb_id": "612-18-3624",
    "name": "Reggie Huels",
    "director": true,
    "diva": false
  },
  {
    "id": 2,
    "imdb_id": "111-55-5160",
    "name": "Megan Grady Jr.",
    "director": false,
    "diva": false
  },
  ...
]
```

| Method | Endpoint | Usage |
| ------ | -------- | ----- |
| GET | `/person/:id` | Get specific person |

### Success

If the request is successful, the response will be a **200**, with the body:

```json
{
  "id": 21,
  "imdb_id": "825-71-4170",
  "name": "Alverta Kemmer",
  "director": false,
  "diva": false
}
```

### Not found

If no person with that ID exists, the response will be a **404**, with the body:

```json
{
  "message": "Couldn't find Person with 'id'=100"
}
```

## Divas

| Method | Endpoint | Usage |
| ------ | -------- | ----- |
| GET | `/divas` | Get list of all divas |

### Success

```json
[
  {
    "id": 8,
    "imdb_id": "nm0381428",
    "name": "Hesperia",
    "director": false,
    "diva": true
  },
  {
    "id": 493,
    "imdb_id": "nm0414294",
    "name": "Maria Jacobini",
    "director": false,
    "diva": true
  },
  ...
]
```

## Directors

| Method | Endpoint | Usage |
| ------ | -------- | ----- |
| GET | `/directors` | Get list of all directors |

### Success

```json
[
  {
    "id": 97,
    "imdb_id": "nm0303120",
    "name": "Carmine Gallone",
    "director": true,
    "diva": false
  },
  {
    "id": 167,
    "imdb_id": "nm0827981",
    "name": "Giuseppe Sterni",
    "director": true,
    "diva": false
  },
  ...
]
```

## Countries

| Method | Endpoint | Usage |
| ------ | -------- | ----- |
| GET | `/countries` | Get list of all countries |

### Success

```json
[
  {
    "id": 1,
    "name": "Italy"
  },
  {
    "id": 2,
    "name": "Germany"
  },
  ...
]
```

## Films

| Method | Endpoint | Usage |
| ------ | -------- | ----- |
| GET | `/films` | Get list of all films |

### Success

```json
[
   {
      "id":4,
      "title": "The Monkey's Raincoat",
      "year":2004,
      "countries": [
         "Saint Vincent and the Grenadines"
      ],
      "directors": [
         {
            "name": "Ms. Lennie Gibson",
            "imdb_id": "491-32-6067"
         }
      ],
      "release_month": "February",
      "release_year":1920,
      "release_location": "United Arab Emirates",
      "production_companies": [
         {
            "name": "JPL",
            "cities": ["Amsterdam", "Haarlem"],
            "country": "Netherlands"
         },
         {
            "name": "SpaceX",
            "cities": ["Vienna"],
            "country": "Austria"
         }
      ],
      "actors": [
         {
            "name": "Flora Severati",
            "imdb_id": "nm2680012"
         }
      ],
      "imdb_id": "395-05-2312"
   },
   ...
]
```
