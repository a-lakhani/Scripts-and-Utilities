#! /bin/bash

fileList="kdeglobals kglobalshortcutsrc khotkeysrc kwinrc plasma-org.kde.plasma.desktop-appletsrc"
configDir="/home/adl/.config"

i3BackupDir="/mnt/SharedHome/.config_i3settings"
plasmaBackupDir="/mnt/SharedHome/.config_kwinsettings"

if [[ $(env | grep KDEWM) == *i3 ]]
	then backupDir=$i3BackupDir
	else backupDir=$plasmaBackupDir;
fi

for f in $fileList; do
	cp $backupDir/$f $configDir/
	printf "%s\t\t%-40s\t%s\t%s\t%s\t%s\n"									\
	"$(date +"%c")"  "$f"  "copied from"  "$backupDir"  "to"  "$configDir"	\
	>> /home/adl/.logs/i3ConfigBackups
done
