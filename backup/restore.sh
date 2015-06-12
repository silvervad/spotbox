#!/bin/bash 
sudo sudo -u postgres dropdb ww_dev
sudo sudo -u postgres createdb -T template0 ww_dev
sudo sudo -u postgres psql ww_dev < ww_dev.dump
rm -rf /home/ubuntu/workspace/ww/public/uploads/photo
tar xvf photos.tgz -C /

