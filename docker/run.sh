#!/bin/bash

# Exit on error
# set -e

USERNAME="$1"
CMD_STRING="$2"

STEAM_DIR="$HOME/Steam"
STEAM_APPS_DIR="$STEAM_DIR/steamapps"
CHIVALRY2_DIR="$STEAM_APPS_DIR/common/Chivalry 2"
PROTON_DIR="$STEAM_APPS_DIR/common/Proton 8.0"

export STEAM_COMPAT_DATA_PATH=~/.local/share/Steam/steamapps/compatdata
export STEAM_COMPAT_CLIENT_INSTALL_PATH=~/.local/share/Steam/

# Install Chivalry 2 if not installed
if [ ! -d "$CHIVALRY2_DIR" ]; then
  echo "Installing Proton 8.x to '$PROTON_DIR'"
  steamcmd \
    +login "$USERNAME" \
    +app_update 2348590 \
    +quit

  echo "Installing Chivalry 2 to '$CHIVALRY2_DIR'..."
  steamcmd \
    +@sSteamCmdForcePlatformType windows \
    +login "$USERNAME" \
    +app_update 1824220 \
    +quit

  echo "Installing C2UMP Launcher"
  wget -o "$CHIVALRY2_DIR/Chivalry2Launcher.exe" 'https://github.com/C2UMP/C2Loader/releases/latest/download/Chivalry2Launcher.exe'

  echo "Installing C2UMP Plugin Loader"
  wget -o "$CHIVALRY2_DIR/TBL/Binaries/Win64/XAPOFX1_5.dll" 'https://github.com/C2UMP/C2PluginLoader/releases/latest/download/XAPOFX1_5.dll'

  echo "Installing Unchained Plugin"
  mkdir "$CHIVALRY2_DIR/TBL/Binaries/Win64/Plugins"
  wget -o "$CHIVALRY2_DIR/TBL/Binaries/Win64/Plugins/UnchainedPlugin.dll" 'https://github.com/Chiv2-Community/UnchainedPlugin/releases/latest/download/UnchainedPlugin.dll'
  
  # Can't be arsed to figure out the correct plugins directory, so just copy it to both
  mkdir "$CHIVALRY2_DIR/Plugins"
  cp "$CHIVALRY2_DIR/TBL/Binaries/Win64/Plugins/UnchainedPlugin.dll" "$CHIVALRY2_DIR/Plugins/UnchainedPlugin.dll"


  echo "Installed files"
  tree "$STEAM_APPS_DIR"
fi

echo "Found $(ls -1 '/mods' | wc -l) mods in /mods"
tree '/mods'
echo ""
echo "Copying mods from /mods to $CHIVALRY2_DIR/TBL/Content/Paks"
rsync -r '/mods' "$CHIVALRY2_DIR/TBL/Content/Paks"

echo ""
echo "Copying config from /config to $CHIVALRY2_DIR"
tree '/config'

rsync -r '/config' "$CHIVALRY2_DIR"

"$PROTON_DIR/proton" "$CHIVALRY2_DIR/Chivalry2Launcher.exe" "$CMD_STRING" -nullrhi -rcon

sleep 10000
