#!/bin/bash

#pull the latest artifactory-pro image from bintray
docker pull jfrog-docker-reg2.bintray.io/jfrog/artifactory-pro:latest


#Build art1
docker build -t artifactory_8081 ./art1
#Build art2
docker build -t artifactory_8082 ./art2

#Build clusterdata
#We'll need to dynamically replace the IP inside storage.properties to the IP of this vagrant host
IP=`ifconfig  | grep inet | grep -v inet6 | head -n3 | tail -n1 | awk '{print $2}'`
echo "Your IP address is: "$IP
sed -e "s/localhost/$IP/g" -i ./clusterhome/storage.properties

docker build -t clusterdata ./clusterhome
#pull & run mysql DB
docker run --name mysql_artdb -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass -d mysql:latest

