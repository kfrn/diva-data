# API Reference

As the dataset is static, the API only supports GET requests.

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
    "diva": false,
    "created_at": "2019-03-19T09:46:43.258Z",
    "updated_at": "2019-03-19T09:46:43.258Z"
  },
  {
    "id": 2,
    "imdb_id": "111-55-5160",
    "name": "Megan Grady Jr.",
    "director": false,
    "diva": false,
    "created_at": "2019-03-19T09:46:43.262Z",
    "updated_at": "2019-03-19T09:46:43.262Z"
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
  "diva": false,
  "created_at": "2019-03-19T09:44:09.256Z",
  "updated_at": "2019-03-19T09:44:09.256Z"
}
```

### Not found

If no person with that ID exists, the response will be a **404**, with the body:

```json
{
  "message":" Couldn't find Person with 'id'=100"
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
    "diva": true,
    "created_at": "2019-03-20T09:31:24.585Z",
    "updated_at": "2019-03-20T09:41:25.463Z"
  },
  {
    "id": 493,
    "imdb_id": "nm0414294",
    "name": "Maria Jacobini",
    "director": false,
    "diva": true,
    "created_at": "2019-03-20T09:31:24.585Z",
    "updated_at": "2019-03-20T09:41:25.501Z"
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
    "diva": false,
    "created_at": "2019-03-20T09:31:24.585Z",
    "updated_at": "2019-03-20T09:49:33.587Z"
  },
  {
    "id": 167,
    "imdb_id": "nm0827981",
    "name": "Giuseppe Sterni",
    "director": true,
    "diva": false,
    "created_at": "2019-03-20T09:31:24.585Z",
    "updated_at": "2019-03-20T09:49:33.942Z"
  },
  ...
]
```
