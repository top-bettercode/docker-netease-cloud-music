FROM bestwu/deepin:panda
MAINTAINER Peter Wu <piterwu@outlook.com>

RUN apt-get update && \
    apt-get install -y locales && \
    echo 'zh_CN.UTF-8 UTF-8' > /etc/locale.gen && \
    locale-gen && \
    echo -e 'LANG="zh_CN.UTF-8"\nLANGUAGE="zh_CN:zh"\n' > /etc/default/locale && \
    source /etc/default/locale && \
    apt-get install -y fonts-wqy-microhei dbus-x11 netease-cloud-music && \
    apt-get -y autoremove && apt-get clean -y && apt-get autoclean -y && \
    rm -rf var/lib/apt/lists/* var/cache/apt/* var/log/*

ENV LANGUAGE=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    LANG=zh_CN.UTF-8 \
    TZ=UTC-8 \
    APP=netease-cloud-music \
    AUDIO_GID=63 \
    GID=1000 \
    UID=1000

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh && \
    groupadd -o -g $GID netease && \
    groupmod -o -g $AUDIO_GID audio && \
    useradd -d "/home/netease" -m -o -u $UID -g netease -G audio,video netease && \
    mkdir -p "/home/netease/Music/.config" "/home/netease/Music/.cache" "/home/netease/.config" "/home/netease/.cache" && \
    ln -s "/home/netease/Music/.config" "/home/netease/.config/netease-cloud-music" && \
    ln -s "/home/netease/Music/.cache" "/home/netease/.cache/netease-cloud-music"

ENTRYPOINT ["/entrypoint.sh"]