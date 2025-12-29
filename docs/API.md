# API Documentation

## Base URL
`http://<backend-ip>/api`

## Endpoints

### Tasks

#### Get All Tasks
`GET /tasks`

Response:
```json
[
  {
    "id": 1,
    "title": "Sample Task",
    "description": "Description",
    "status": "pending",
    "created_at": "2024-01-01T00:00:00.000Z"
  }
]
```

[Continue with other endpoints...]