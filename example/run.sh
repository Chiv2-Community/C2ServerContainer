#!/bin/bash

MOD_DIR="$1"
CONFIG_DIR="$2"
USERNAME="$3"
CMD_STRING="$4"

# docker pull jacoby6000/C2ServerContainer:latest
STEAM_DIR="/home/root/.steam/steam"
STEAM_APPS_DIR="$STEAM_DIR/steamapps"

docker volume create steamcmd_login_volume
docker volume create steamcmd_volume

docker run \
  -it \
  --rm \
  --name chivalry2-server \
  -p 3075:3075/udp \
  -p 7071:7071/udp \
  -p 7777:7777/udp \
  -v "$MOD_DIR":/mods \
  -v "$CONFIG_DIR":/config \
  -v "steamcmd_login_volume:/home/steam/Steam" \
  -v "steamcmd_volume:/home/steam/steamcmd" \
  jacoby6000/chiv2-container:latest $USERNAME $CMD_STRING
