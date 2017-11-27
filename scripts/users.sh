#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/users"
curl "${API}${URL_PATH}" \
  --include \
  --request GET \
  --header "Authorization: Token token=BAhJIiU0ODlkZTZkODg4NzU2MTgwMmRjMzc2NmJjYTg1NDQwYgY6BkVG--2bbdb96d3ac8210961fdeba4a0d5abfc6c7ce8eb"

echo
