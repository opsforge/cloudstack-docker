#!/bin/bash

if [ ! -d /var/cloudstack/management/.ssh ]; then
	mknod /dev/loop6 -m0660 b 7 6
fi

until nc -z mysql 3306; do
    echo "waiting for mysql-server..."
    sleep 1
done

mysql -p"$mysqlpass" -h mysql \
   -e "show databases;"|grep -q cloud

case $? in
  1)
	echo "deploying new cloud databases"
	INITIATED=false
	cloudstack-setup-databases cloud:password@mysql \
	--deploy-as=root:$mysqlpass
    ;;
  0)
	echo "using existing databases"
	INITIATED=true
	cloudstack-setup-databases cloud:password@mysql
    ;;
  *)
	echo "cannot access database"
	exit 12
    ;;
esac

service cloudstack-management start
sleep 10

if [ ! -d /export/secondary ]; then
  mkdir -p /export/secondary
  chmod -R 0777 /export
  exportfs -a
fi

if [ ! -d /export/primary ]; then
  mkdir -p /export/primary
  chmod -R 0777 /export
  exportfs -a
fi

if [ $DEPLOYVMWARE ]; then
  /usr/share/cloudstack-common/scripts/storage/secondary/cloud-install-sys-tmplt -m /export/secondary -u http://cloudstack.apt-get.eu/systemvm/4.6/systemvm64template-4.6.0-vmware.ova -h vmware
  service cloudstack-management restart
  sleep 10
fi

if [ $DEPLOYHYPERV ]; then
  /usr/share/cloudstack-common/scripts/storage/secondary/cloud-install-sys-tmplt -m /export/secondary -u http://cloudstack.apt-get.eu/systemvm/4.6/systemvm64template-4.6.0-hyperv.vhd.zip -h hyperv
  service cloudstack-management restart
  sleep 10
fi

tail -f /var/log/cloudstack/management/management-server.log
