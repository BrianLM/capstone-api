#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/levels"
curl "${API}${URL_PATH}" \
  --include \
  --request GET \
  --header "Authorization: Token token=BAhJIiVhZjI0ZTZjYTcxOGNiN2NmM2ZhNGRmYWNkYTIzZGVhYwY6BkVG--44d6a49c9ba7b64994edae9201a8eda8bbe16568"

echo
