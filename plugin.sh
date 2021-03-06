#!/bin/bash

# needed variables taken from environment
TOKEN=${PLUGIN_TOKEN}
CONTAINER=${PLUGIN_CONTAINER}
APP=${PLUGIN_APP}

# will be used to release app to heroku
PAYLOAD='{
  "updates": [
    {
      "type": "web",
      "docker_image": "IMAGE_ID_TO_REPLACE"
    }
  ]
}'

echo "using Container=${CONTAINER}"
echo "using APP=${APP}"

# download the container image first 
echo "downloading docker image ..."
docker pull ${CONTAINER}

# tag and push docker to heroku registry
echo ${TOKEN} | docker login --username=_ --password-stdin registry.heroku.com
docker tag ${CONTAINER} registry.heroku.com/${APP}/web
docker push registry.heroku.com/${APP}/web

# get the image id and adjust the payload
IMAGE_ID=$(docker inspect ${CONTAINER} --format {{.Id}})
echo "using imageid=${IMAGE_ID}"
PATCH_PAYLOAD=${PAYLOAD/IMAGE_ID_TO_REPLACE/$IMAGE_ID}

# deploy (release) the image to the specified heroku app via api call
curl -u _:${TOKEN} -n -X PATCH https://api.heroku.com/apps/${APP}/formation \
  -d "${PATCH_PAYLOAD}" \
  -H "Content-Type: application/json" \
  -H "Accept: application/vnd.heroku+json; version=3.docker-releases"