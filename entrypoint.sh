#!/bin/bash

groupmod -o -g $AUDIO_GID audio

if [ $GID != $(echo `id -g netease`) ]; then
    groupmod -o -g $GID netease
fi
if [ $UID != $(echo `id -u netease`) ]; then
    usermod -o -u $UID netease
fi
chown netease:netease /home/netease/Music

su netease <<EOF
if [ ! -e "/home/netease/.inited" ]; then
    echo '初始化'
    mkdir -p "/home/netease/Music/.config" "/home/netease/Music/.cache" "/home/netease/.config" "/home/netease/.cache"
    ln -s "/home/netease/Music/.config" "/home/netease/.config/netease-cloud-music"
    ln -s "/home/netease/Music/.cache" "/home/netease/.cache/netease-cloud-music"
    touch "/home/netease/.inited"
fi
echo "启动 $APP"
netease-cloud-music $1
exit 0
EOF