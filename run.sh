#!/bin/bash
# 

name=base-dev-tools
sudo docker stop ibbd-$name
sudo docker rm ibbd-$name

sudo docker run -ti --rm --name=ibbd-$name \
    -v /var/www:/var/www \
    -w /var/www \
    ibbd/$name \
    tmux

