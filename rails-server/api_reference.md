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
