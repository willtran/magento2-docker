#!/usr/bin/env bash
# Start docker-sync and docker-compose separately. Update this when docker-sync-stack has a detached mode
docker-sync start

ip="$(ipconfig getifaddr en0)"

if [[ ! -z $ip ]]; then
    mv ./docker/web/conf/zz-custom.ini ./docker/web/conf/zz-custom.ini.tmp
    sed "s/127.0.0.1/$ip/" ./docker/web/conf/zz-custom.ini.tmp > ./docker/web/conf/zz-custom.ini
    docker-compose build web
    mv ./docker/web/conf/zz-custom.ini.tmp ./docker/web/conf/zz-custom.ini
fi

docker-compose up -d
docker cp libs/env.php.docker "$(docker-compose ps -q web)":/var/www/magento/app/etc/env.php
