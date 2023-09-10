#!/bin/bash

# Exit on error
# set -e

USERNAME="$1"
CMD_STRING="$2"

CHIVALRY2_DIR='/opt/Chivalry2'

# Install Chivalry 2 if not installed
if [ ! -d $CHIVALRY2_DIR ]; then
  echo "Installing Proton 8.x"
  steamcmd \
    +force_install_dir $CHIVALRY2_DIR \
    +login "$USERNAME" \
    +app_update 2348590 \
    +quit

  echo "Installing Chivalry 2 to '/opt/Chivalry 2'..."
  steamcmd \
    +@sSteamCmdForcePlatformType windows \
    +force_install_dir $CHIVALRY2_DIR \
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
fi

echo "Found $(ls -1 '/mods' | wc -l) mods in /mods"
echo $(tree '/mods')
echo ""
echo "Copying mods from /mods to $CHIVALRY2_DIR/TBL/Content/Paks"
rsync -r '/mods' "$CHIVALRY2_DIR/TBL/Content/Paks"

echo ""
echo "Copying config from /config to $CHIVALRY2_DIR"
echo $(tree '/config')

rsync -r '/config' "$CHIVALRY2_DIR"

$CHIVALRY2_DIR/proton $CHIVALRY2_DIR/Chivalry2Launcher.exe "$CMD_STRING" -nullrhi -rcon

sleep 10000