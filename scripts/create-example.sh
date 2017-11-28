#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/explorations/1?attack"
curl "${API}${URL_PATH}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=BAhJIiU4YWY4OGRmMzEwNzhjMDQzOWY1NmMwZDcwZjc3OGFlOQY6BkVG--e37b1f6db1396bd9ba45c9514e51f5fbe1dc4f43" \
  --data '{
    "exploration": {
      "area": "Desert",
      "dif": 1
    }
  }'

echo
