# ha-builder
A repo for the ha-builder scripts and Dockerfiles

## Setup ##

### Prerequirsites ###
-Docker CLI installed, runnable without 'sudo' (or modify habuilder.sh to use sudo for docker commands) 

-Two valid Artifactory HA licenses

### Build the images ###
1.Clone this repo to your host
`git clone https://github.com/jfrog-support/ha-builder.git`

2.The habuilder.sh shell script will try to figure out your host IP and modify the ha-builder/clusterhome/stroage.properties file accordingly, however you may need to modify this section to make it work with your own system:
```bash
#We'll need to dynamically replace the IP inside storage.properties to the IP of this vagrant host
IP=`ifconfig  | grep inet | grep -v inet6 | head -n3 | tail -n1 | awk '{print $2}'`
echo "Your IP address is: "$IP
sed -e "s/localhost/$IP/g" -i ./clusterhome/storage.properties

```
Otherwise, just replace the IP address inside ha-builder/clusterhome/storage.properties before running habuilder.sh

3.Run the script `sh habuilder.sh`

When the script finishes, you'll have 3 new docker images at your disposal:

`artifactory_8081`

`artifactory_8082`
  
`clusterdata`


If needed, it will also pull the base artifactory-pro image from Bintray, the ubuntu image (used for the clusterdata image), and the mysql image:
![Alt text](https://s3-eu-west-1.amazonaws.com/uploads-eu.hipchat.com/19904/1162299/Yl2Ybjv5Ccm382L/images.png)

### Up & Running ###
1.Spawn an ephemeral container to access the mysql shell of the “mysql_artdb” container we spawned earlier. The “--rm” flag means the container will delete itself as soon as the shell is exited.

`docker run -it --link mysql_artdb:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"pass"'`

2.When inside the mysql shell, create the artdb schema:

`CREATE DATABASE artdb CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL ON artdb.* TO 'artifactory'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;`

3.Spawn a data container named "cluster_home" from our "clusterdata" image: 

`docker run --name cluster_home -d  clusterdata`

4.Run the two artifactory nodes:

`docker run -d -p 8081:8081 --name art1 --volumes-from cluster_home artifactory_8081`

`docker run -d -p 8082:8082 --name art2 --volumes-from cluster_home artifactory_8082`

6.Since both nodes were intitialised without a license, Artifactory will start in Offline Mode. Acquire bash access to both nodes with 'docker exec -it art{1|2} /bin/bash', and manually create the artifactory.lic files. After doing that, 'service artifactory restart', and your done! Enjoy.

