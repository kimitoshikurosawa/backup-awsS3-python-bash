#!/bin/bash
dir="/mnt/data"
log=/home/ubuntu/logs/documents.txt
# create log file or override if already present
printf "Log File - " > $log
# append date to log file
date >> $log
cd $dir || exit
# Sync Documents folder from S3
echo -e '\e[1m\e[34mSync S3 Documents..\e[0m\n'>> $log
sudo aws s3 sync s3://[bucket-location] [newlocation]
echo -e '\e[1m\e[34m\nDocuments Downloaded.. now will zip all\e[0m\n'>> $log
sudo rm documents.zip
sudo zip -r documents documents
echo -e '\e[1m\e[34m\nCopy documents to onPrem..\e[0m\n'>> $log
sudo sshpass -p [password] rsync -a --delete documents.zip root@[distant-ip]:/home/documents
echo -e '\e[1m\e[34m\nDocuments Copied\e[0m\n'>> $log