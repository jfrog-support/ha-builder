from ubuntu

MAINTAINER Uriah L. "uriahl@jfrog.com"

####Build clusterhome####

RUN groupadd -r artifactory \
  && useradd -r -g artifactory artifactory

RUN mkdir /clusterhome
RUN mkdir /clusterhome/ha-etc 
RUN mkdir /clusterhome/ha-data 
RUN mkdir /clusterhome/ha-backup \ 
	&& chown -R artifactory:artifactory /clusterhome

ADD ./storage.properties /clusterhome/ha-etc/
ADD ./cluster.properties /clusterhome/ha-etc/
ADD ./artifactory.system.properties /clusterhome/ha-etc/
ADD ./logback.xml /clusterhome/ha-etc/
ADD ./mimetypes.xml /clusterhome/ha-etc/

VOLUME /clusterhome

ENTRYPOINT ["tail", "-f", "/dev/null"]
