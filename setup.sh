#!/bin/bash

USERNAME="$1"
steamcmd \
  +@sSteamCmdForcePlatformType windows \
  +force_install_dir '/opt/Chivalry 2' \
  +login "$USERNAME" \
  +app_update 1824220 validate \
  +quit

# C2UMP's launcher is fully headless and does exactly what we need.
# We also need XAPO, and the unchained plugin.
wget -o '/opt/Chivalry 2/Chivalry2Launcher.exe' https://github.com/C2UMP/C2Loader/releases/latest/download/Chivalry2Launcher.exe