export ARTIFACTORY_HOME=/var/opt/jfrog/artifactory 
chown -R artifactory:artifactory /clusterhome
service artifactory start
tail -f /dev/null
