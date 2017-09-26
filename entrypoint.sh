#!/bin/bash

groupmod -o -g $AUDIO_GID audio
groupmod -o -g $GID netease
if [ $UID != $(echo `id -u netease`) ]; then
    usermod -o -u $UID netease
fi
if [ ! -d "/home/netease/Music/.config" ]; then
    mkdir -p "/home/netease/Music/.config"
fi
if [ ! -d "/home/netease/Music/.cache" ]; then
    mkdir -p "/home/netease/Music/.cache"
fi

chown -R netease:netease /home/netease/Music

su netease <<EOF
    echo "启动 $APP"
    netease-cloud-music $1
exit 0
EOF