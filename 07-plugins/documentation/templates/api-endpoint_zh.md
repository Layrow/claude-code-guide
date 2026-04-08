# [METHOD] /api/v1/[endpoint]

## Description
简要说明这个 endpoint 的作用。

## Authentication
所需认证方式（例如 Bearer token）。

## Parameters

### Path Parameters
| Name | Type | Required | Description |
|------|------|----------|-------------|
| id | string | Yes | 资源 ID |

### Query Parameters
| Name | Type | Required | Description |
|------|------|----------|-------------|
| page | integer | No | 页码（默认：1） |
| limit | integer | No | 每页条目数（默认：20） |

### Request Body
```json
{
  "field": "value"
}
```

## Responses

### 200 OK
```json
{
  "success": true,
  "data": {
    "id": "123",
    "name": "Example"
  }
}
```

### 400 Bad Request
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input"
  }
}
```

### 404 Not Found
```json
{
  "success": false,
  "error": {
    "code": "NOT_FOUND",
    "message": "Resource not found"
  }
}
```

## Examples

### cURL
```bash
curl -X GET "https://api.example.com/api/v1/endpoint" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json"
```

### JavaScript
```javascript
const response = await fetch('/api/v1/endpoint', {
  headers: {
    'Authorization': 'Bearer token',
    'Content-Type': 'application/json'
  }
});
const data = await response.json();
```

### Python
```python
import requests

response = requests.get(
    'https://api.example.com/api/v1/endpoint',
    headers={'Authorization': 'Bearer token'}
)
data = response.json()
```

## Rate Limits
- 已认证用户每小时 1000 次请求
- 公开 endpoints 每小时 100 次请求

## Related Endpoints
- [GET /api/v1/related](#)
- [POST /api/v1/related](#)
