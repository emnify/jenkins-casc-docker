#!/bin/bash

if [ ! -f ./jenkins.env ]; then
  cp .env.template jenkins.env
fi

if [ ! -d ./data ]; then
  mkdir ./data
  sudo chown 1000:1000 ./data
fi

docker-compose up
