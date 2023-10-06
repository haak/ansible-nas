#!/bin/bash

variable=$(docker ps -a -q --filter name=qbittorrent)
echo $variable


if [ -z "$variable" ]
then
      echo "\$var is empty"
else
      docker stop $variable & docker kill $variable & docker rm $variable
fi

variable=$(docker ps -a -q --filter name=gluetun)
echo $variable

if [ -z "$variable" ]
then
      echo "\$var is empty"
else
      docker stop $variable & docker kill $variable & docker rm $variable
fi