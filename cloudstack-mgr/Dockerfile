# Dockerfile of Apache CloudStack mgmt. server on CentOS

FROM centos:7

MAINTAINER opsforge.io
LABEL name="cloudstack"
LABEL version="0.0.1"

CMD /bin/zsh -c '???'

USER root

RUN echo -e "[cloudstack] \n\
name=cloudstack \n\
baseurl=http://cloudstack.apt-get.eu/centos7/4.9/ \n\
enabled=1 \n\
gpgcheck=0" >> /etc/yum.repos.d/cloudstack.repo

RUN echo -e "[mysql-community] \n\
name=MySQL Community connectors \n\
baseurl=http://repo.mysql.com/yum/mysql-connectors-community/el/7/x86_64/ \n\
enabled=1" >> /etc/yum.repos.d/mysql.repo

RUN rpm --import http://repo.mysql.com/RPM-GPG-KEY-mysql && \
    yum update -y && \
    yum install ntp mysql-connector-python cloudstack-management -y && \
    yum clean all -y
