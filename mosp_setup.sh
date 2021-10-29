#!/bin/bash

set -eu

yum update -y
yum install -y java-1.8.0-openjdk-devel
yum install -y tomcat tomcat-webapps tomcat-admin-webapps
yum install -y httpd

echo 'ProxyPass /time4/srv/ ajp://localhost:8009/time4/srv/' >> /etc/httpd/conf.d/proxy_ajp.conf
echo 'ProxyPass /time4/pub/ ajp://localhost:8009/time4/pub/' >> /etc/httpd/conf.d/proxy_ajp.conf

systemctl enable httpd
systemctl enable tomcat

yum install -y postgresql-server
postgresql-setup initdb
mv -f /home/usermosp/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf
chown postgres:postgres /var/lib/pgsql/data/pg_hba.conf
systemctl enable postgresql
systemctl start postgresql

chown usermosp:tomcat /home/usermosp/time4.war
chown 775 /home/usermosp/time4.war

mv /home/usermosp/time4.war /usr/share/tomcat/webapps/.

systemctl restart httpd
systemctl restart tomcat