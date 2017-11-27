#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/explorations"
curl "${API}${URL_PATH}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=BAhJIiVhZjI0ZTZjYTcxOGNiN2NmM2ZhNGRmYWNkYTIzZGVhYwY6BkVG--44d6a49c9ba7b64994edae9201a8eda8bbe16568" \
  --data '{
    "exploration": {
      "current": "Forest, none"
    }
  }'

echo
