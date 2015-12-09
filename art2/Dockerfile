FROM jfrog-docker-reg2.bintray.io/jfrog/artifactory-pro:latest


MAINTAINER Uriah L. "uriahl@jfrog.com"

####Build art2####

#Commenting out the artifactory.lic adding til we get a private repo
#Add artifactory.lic
#ADD ./artifactory.lic_b /var/opt/jfrog/artifactory/etc/artifactory.lic
#RUN chown artifactory /var/opt/jfrog/artifactory/etc/artifactory.lic
#Add ha-node.properties
ADD ./ha-node.properties_b /var/opt/jfrog/artifactory/etc/ha-node.properties
RUN chown artifactory /var/opt/jfrog/artifactory/etc/ha-node.properties
#Add the mysql JDBC driver
ADD ./mysql-connector-java-5.1.36-bin.jar /var/opt/jfrog/artifactory/tomcat/lib/
RUN chown artifactory /var/opt/jfrog/artifactory/tomcat/lib/mysql-connector-java-5.1.36-bin.jar
#Add a modified server.xml, tomcat connector listening on 8082
ADD ./server.xml	/var/opt/jfrog/artifactory/tomcat/conf/
RUN chown artifactory /var/opt/jfrog/artifactory/tomcat/conf/server.xml

ADD ./entrypoint.sh /
VOLUME /clusterhome


EXPOSE 8082

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]



