#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/explorations"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=BAhJIiU2OWU1MmMwOTRlOWExZjFhMGU5ZjAwNGJmYTgxNWU2NQY6BkVG--da78d263517fc28a57809631aa6d1946412cc22e" \
  --data '{
    "exploration": {
      "area": "Forest"
    }
  }'

echo
