#!/bin/bash
data_path=""
name="/i3cheats"
# = Create folder in which to save all the cheatsheets =
if [ ! -z "${XDG_DATA_HOME}"  ]; then
  data_path=$XDG_DATA_HOME$name
  echo 'using XGD_DATA_HOME for data location path'
else
  data_path="${HOME}/.local/share${name}"
  echo "XGD_DATA_HOME not set. using default data home"
fi

mkdir -p $data_path
cp -r cheatsheets/* $data_path
echo "installed cheatsheets into: $data_path"
# = Add cheatsheetdir just created into the config such that
# the main script knows where to look when hotkey is pressed.
echo "cheatsheetdir=$data_path" >> $(dirname $0)/config

# = Last step. Add the line "source <config_path>" to the script such that the script uses the terminals and location of cheatsheetfolder 
# 
config_path=""
if [ ! -z "${XDG_CONFIG_HOME}"  ]; then
  config_path=$XDG_CONFIG_HOME$name
  echo 'using XGD_CONFIG_HOME for config location path'
else
  config_path=${HOME}/.config${name}
  echo "XGD_CONFIG_HOME not set. using default"
fi
mkdir -p $config_path
mv $(dirname $0)/config ${config_path}/
echo "put config into: ${config_path}/config"
sed -i  "6s|\#install_insert_cfg|source ${config_path}/config|" cheatsheet-toggle.sh
