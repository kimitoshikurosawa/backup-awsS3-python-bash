#!/bin/bash
dir="/mnt/data/dumps"
log=/home/ubuntu/logs/dumps.txt
# create log file or override if already present
printf "Log File - " > $log
# append date to log file
date >> $log
cd $dir || exit
sudo rm mongodump.archive
# Execute the Python script to download last dump from s3
echo -e '\e[1m\e[34mRetrieve last mongo..\e[0m\n'>> $log
sudo python3 mongodump.py
echo -e '\e[1m\e[34m\nCopy dump to onPrem..\e[0m\n'>> $log
sudo sshpass -p [password] rsync -a --delete mongodump.archive root@[distant-ip]:/home/dump
echo -e '\e[1m\e[34m\nDump copied and extracted\e[0m\n'>> $log

echo -e '\e[1m\e[34m\nDatabase Restore Complete\e[0m\n'>> $log