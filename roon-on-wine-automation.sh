#!/bin/bash

# Make sure this script is executable

INSTANCE_NAME="my_roon_instance"
ROON_DIR="drive_c/users/$USER/AppData/Local/Roon"
SETTINGS_DIR="Settings"
CLIENT_DIR="Database/Registry/Client"

INFOCOLOR="\e[94m" # Light Blue
ROWCOLOR="\e[93m" # Light Yellow
WARNINGCOLOR="\e[31m" # Red
ENDCOLOR="\e[0m"

echo
echo -e "${WARNINGCOLOR}###################################################################${ENDCOLOR}"
echo -e "${WARNINGCOLOR}# Please make sure your Roon Remote on this machine is closed!    #${ENDCOLOR}"
echo -e "${WARNINGCOLOR}###################################################################${ENDCOLOR}"
sleep 5

# Removing previous master.zip file.
rm -f master.zip

# Removing previous roon-on-wine-master directory.
rm -rf roon-on-wine-master

# Removing previous instance backup
rm -rf $HOME/$INSTANCE_NAME.bak

echo
echo -e "${INFOCOLOR}Backing up previous my_roon_instance folder ...${ENDCOLOR}"
mv -f $HOME/$INSTANCE_NAME $HOME/$INSTANCE_NAME.bak

# Backing up previous start_my_roon_instance script in the case e.g. SCALEFACTOR was edited.
mv -f $HOME/start_$INSTANCE_NAME.sh $HOME/start_$INSTANCE_NAME.sh.bak

echo
echo -e "${INFOCOLOR}Downloading newest roon-on-wine archive from GitHub ...${ENDCOLOR}"
wget https://github.com/RoPieee/roon-on-wine/archive/refs/heads/master.zip

echo
echo -e "${INFOCOLOR}Extracting archive ...${ENDCOLOR}"
unzip master.zip

# Switching to roon-on-wine-master directory.
cd roon-on-wine-master

echo
echo -e "${ROWCOLOR}Executing roon-on-wine ...${ENDCOLOR}"
echo
echo -e "${ROWCOLOR}Please be patient and wait for the Roon setup dialog!${ENDCOLOR}"
echo
echo -e "${WARNINGCOLOR}###################################################################${ENDCOLOR}"
echo -e "${WARNINGCOLOR}# Don't start Roon through the setup dialog (uncheck)!            #${ENDCOLOR}"
echo -e "${WARNINGCOLOR}# Otherwise, it is not possible to restore the previous settings. #${ENDCOLOR}"
echo -e "${WARNINGCOLOR}###################################################################${ENDCOLOR}"
echo
echo -e "${ROWCOLOR}"
./install.sh
echo -e "${ENDCOLOR}"


# Restoring previous settings.

mv -f $HOME/start_$INSTANCE_NAME.sh.bak $HOME/start_$INSTANCE_NAME.sh

#mkdir -p $HOME/$INSTANCE_NAME/$ROON_DIR/$SETTINGS_DIR
cp -fR $HOME/$INSTANCE_NAME.bak/$ROON_DIR/$SETTINGS_DIR $HOME/$INSTANCE_NAME/$ROON_DIR 2>/dev/null

#mkdir -p $HOME/$INSTANCE_NAME/$ROON_DIR/$CLIENT_DIR
cp -fR $HOME/$INSTANCE_NAME.bak/$ROON_DIR/$CLIENT_DIR $HOME/$INSTANCE_NAME/$ROON_DIR 2>/dev/null

sleep 5 # Too make sure all files are copied before starting Roon.


echo
echo -e "${INFOCOLOR}You can now start Roon via the start menu!"
echo
