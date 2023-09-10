#!/bin/bash

MOD_DIR=$1
CONFIG_DIR=$2
USERNAME=$3
CMD_STRING=$4

# docker pull jacoby6000/C2ServerContainer:latest

docker run \
  -it \
  --rm \
  --name chivalry2-server \
  -p 3075:3075/udp \
  -p 7071:7071/udp \
  -p 7777:7777/udp \
  -v "$MOD_DIR":/mods \
  -v "$CONFIG_DIR":/config \
  jacoby6000/chiv2-container:latest $USERNAME $CMD_STRING