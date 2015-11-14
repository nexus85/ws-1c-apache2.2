#ws_1c_apache2.2

FROM ubuntu:12.04
MAINTAINER trantor77

RUN apt-get update \
    && apt-get install -y apache2

ADD deb64.tar.gz /tmp
WORKDIR /tmp
RUN find *-nls_*.* -delete \
    && dpkg -i /tmp/* \
    && rm /tmp/*

RUN /opt/1C/v8.3/x86_64/webinst -apache22 \
    -wsdir 1c_buh -dir /wwwroot/1c_pub  \ 
    -connstr "Srvr=127.0.0.1;Ref=test;" \ 
    -confPath /etc/apache2/httpd.conf

WORKDIR /
ADD start.sh /start.sh
RUN chmod +x /start.sh
CMD /start.sh

EXPOSE 80