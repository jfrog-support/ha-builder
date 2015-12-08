FROM jfrog-docker-reg2.bintray.io/jfrog/artifactory-pro:latest


MAINTAINER Uriah L. "uriahl@jfrog.com"

####Build art1####

#Add artifactory.lic
ADD ./artifactory.lic /var/opt/jfrog/artifactory/etc/
RUN chown artifactory /var/opt/jfrog/artifactory/etc/artifactory.lic
#Add ha-node.properties
ADD ./ha-node.properties /var/opt/jfrog/artifactory/etc/
RUN chown artifactory /var/opt/jfrog/artifactory/etc/ha-node.properties
#Add the mysql JDBC driver
ADD ./mysql-connector-java-5.1.36-bin.jar /var/opt/jfrog/artifactory/tomcat/lib/
RUN chown artifactory /var/opt/jfrog/artifactory/tomcat/lib/mysql-connector-java-5.1.36-bin.jar
ADD ./entrypoint.sh /
VOLUME /clusterhome


EXPOSE 8081

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
