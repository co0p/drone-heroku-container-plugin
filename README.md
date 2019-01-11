drone-heroku-container-plugin
===================

This plugin allows you to push and release an existing image on docker hub on heroku using heroku's container service.

Usage
------
 
The interaction with heroku is happening using docker commands and a little bit of curl. Therefore the plugin
needs access to the underlying docker sock, provided via the volumes directive in the pipeline definition.

__IMPORTANT: This images needs privileged access (Settings -> trusted)__

```
pipeline:
  deploy:
    image: co0p/drone-heroku-container-plugin
    container: <your/docker/image>
    app: <your/heroku/app/name>
    token: <your/heroku/access/token>
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      ```

Requirements
------------

 * one app, one container. The app will be deployed as a WEB dyno
 * 