#!/bin/sh
groupadd -r $USER -g 433 \
&& useradd -u 431 -r -g $USER -d /home/$USER -s /bin/bash -c "$USER" $USER \
&& adduser $USER sudo \
&& mkdir /home/$USER \
&& chown -R $USER:$USER /home/$USER \
&& echo $USER':'$PASSWORD | chpasswd
/etc/NX/nxserver --startup

# create desktop links for open Chrome and pycharm
mkdir /home/$USER/Desktop
chown -R $USER:$USER /home/$USER/Desktop
echo $'#!/usr/bin/env bash\n/usr/bin/chromium-browser --no-sandbox' >  /home/$USER/Desktop/chrome
chmod 777 /home/$USER/Desktop/chrome
ln -s /usr/bin/pycharm /home/$USER/Desktop/pycharm

jupyter notebook --port=8888 --allow-root --ip=0.0.0.0 --notebook-dir="/workspace/notebook"
