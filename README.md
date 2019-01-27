drone-heroku-plugin
===================

This plugin allows you to deploy a docker image to heroku using the drone ci (v0.8x) .

example pipeline:
-----------------

 * container: Where to pull the docker image from
 * app: the heroku app to deploy to
 * heroku_token: your heroku api key to access heroku  

The heroku token should be saved in drone's secrets vault.

```deploy:
    image: co0p/drone-heroku-plugin
    container: you/container
    app: <your/heroku/app>
    secrets: [ heroku_token ]```




