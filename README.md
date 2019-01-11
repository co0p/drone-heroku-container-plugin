drone-heroku-container-plugin
===================

This plugin allows you to push and release an existing image on docker hub on heroku using heroku's container service.

Usage
------
 
```
pipeline:
  deploy:
    image: co0p/drone-heroku-container-plugin
    container: co0p/advertdesk-api
    app: advertdesk-api
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      ```