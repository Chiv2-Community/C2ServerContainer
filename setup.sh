#!/bin/bash

USERNAME="$1"

# Install Chivalry 2 if not installed
if [ ! -d '/opt/Chivalry 2' ]; then
  echo "Installing Chivalry 2 to '/opt/Chivalry 2'..."

  mkdir '/opt/Chivalry 2'
  steamcmd \
    +@sSteamCmdForcePlatformType windows \
    +force_install_dir '/opt/Chivalry 2' \
    +login "$USERNAME" \
    +app_update 1824220 validate \
    +quit

    echo "Installing C2UMP Launcher"
    wget -o '/opt/Chivalry 2/Chivalry2Launcher.exe' 'https://github.com/C2UMP/C2Loader/releases/latest/download/Chivalry2Launcher.exe'

    echo "Installing C2UMP Plugin Loader"
    wget -o '/opt/Chivalry 2/TBL/Binaries/Win64/XAPOFX1_5.dll' 'https://github.com/C2UMP/C2PluginLoader/releases/latest/download/XAPOFX1_5.dll'

    echo "Installing Unchained Plugin"
    mkdir '/opt/Chivalry 2/TBL/Binaries/Win64/Plugins'
    wget -o '/opt/Chivalry 2/TBL/Binaries/Win64/Plugins/UnchainedPlugin.dll' 'https://github.com/Chiv2-Community/UnchainedPlugin/releases/latest/download/UnchainedPlugin.dll'
    
    # Can't be arsed to figure out the correct plugins directory, so just copy it to both
    mkdir '/opt/Chivalry 2/Plugins'
    cp '/opt/Chivalry 2/TBL/Binaries/Win64/Plugins/UnchainedPlugin.dll' '/opt/Chivalry 2/Plugins/UnchainedPlugin.dll'
fi

echo "Found $(ls -1 '/mods' | wc -l) mods in /mods"
echo $(ls -1 '/mods')
echo ""
echo "Copying mods from /mods to /opt/Chivalry 2/TBL/Content/Paks"
cp -r '/mods' '/opt/Chivalry 2/TBL/Content/Paks'

