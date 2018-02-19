#!/usr/bin/env bash

mkdir /var/supervisord
cd /var/supervisord
supervisord -n -c /etc/supervisord.conf