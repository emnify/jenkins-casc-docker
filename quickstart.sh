#!/bin/bash

if [ ! -f ./jenkins.env ]; then
  cp .env.template jenkins.env
fi

docker-compose up
