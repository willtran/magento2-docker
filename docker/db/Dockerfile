FROM mariadb:10.2

MAINTAINER "William Tran" <will@wtran.net>

RUN sed -ire 's/max_allowed_packet.*=.*/max_allowed_packet = 128M/g' /etc/mysql/my.cnf && \
    sed -ire 's/connect_timeout.*=.*/connect_timeout = 60/g' /etc/mysql/my.cnf
