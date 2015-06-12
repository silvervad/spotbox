#!/bin/bash 
#today=`date +%Y-%m-%d.%H:%M:%S`
sudo sudo -u postgres pg_dump ww_dev > "ww_dev.dump"
tar cvzf photos.tgz /home/ubuntu/workspace/ww/public/uploads/photo/*