#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/creatures"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=BAhJIiVlMGQxNjFmYTcyNTZjN2ExNTBmOGEwMTZmZTY5ODczNAY6BkVG--d4889a450f78847774a28bb784de8d8283fe07d4" \
  --data '{
    "creature": {
      "c_hp": "1"
    }
  }'

echo
