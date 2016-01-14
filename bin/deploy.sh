#!/bin/bash

sudo bash -c "bin/inline.sh nginx.conf > /etc/nginx/nginx.conf"

if sudo bash -c "nginx -t"
then
    echo "restart nginx"
    sudo systemctl restart nginx
fi
