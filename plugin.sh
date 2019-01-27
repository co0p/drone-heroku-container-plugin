#/bin/sh

# needed variables taken from environment
TOKEN=${PLUGIN_HEROKU_TOKEN}
CONTAINER=${PLUGIN_CONTAINER}
APP=${PLUGIN_APP}
PAYLOAD='{
  "updates": [
    {
      "type": "web",
      "docker_image": "IMAGE_ID_TO_REPLACE"
    }
  ]
}'

# 1. tag and push docker to heroku registry
echo ${TOKEN} | docker login --username=_ --password-stdin registry.heroku.com
docker tag ${CONTAINER} registry.heroku.com/${APP}/web
docker push registry.heroku.com/${APP}/web

# 2. get the image id... 
IMAGE_ID=$(docker inspect ${CONTAINER} --format {{.Id}})
PATCH_PAYLOAD=${PAYLOAD/IMAGE_ID_TO_REPLACE/$IMAGE_ID}

# 3. to deploy (release) the image to the specified heroku app
curl -u _:${TOKEN} -n -X PATCH https://api.heroku.com/apps/${APP}/formation \
  -d "${PATCH_PAYLOAD}" \
  -H "Content-Type: application/json" \
  -H "Accept: application/vnd.heroku+json; version=3.docker-releases"