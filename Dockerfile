FROM manythumbed/docker-java
MAINTAINER Tim Clark <t.i.j.clark@gmail.com>

RUN opkg-install bash

ENV ZOOKEEPER_HOME /usr/zookeeper-3.4.6

RUN curl \
 --silent \
 --location \
 "http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz" \
 | gunzip \
 | tar x -C /usr/ \
 && ln -s $ZOOKEEPER_HOME /usr/zookeeper \
 && cp $ZOOKEEPER_HOME/conf/zoo_sample.cfg $ZOOKEEPER_HOME/conf/zoo.cfg \
 && mkdir -p /tmp/zookeeper

EXPOSE 2181 2888 3888

WORKDIR /usr/zookeeper

VOLUME ["/usr/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/usr/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
