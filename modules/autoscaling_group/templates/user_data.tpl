#!/bin/bash -xe
yum update -y
# install git
yum install git -y

# download ansible_moodle

git clone https://github.com/mikomeister/ansible_moodle.git /home/ec2-user/ansible

#Create directory structure
mkdir -p /var/www/moodle/html
mkdir -p /var/www/moodle/data
mkdir -p /var/www/moodle/cache
mkdir -p /var/www/moodle/temp
mkdir -p /var/www/moodle/local

mkdir -p /tmp/efs
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 "${efs_address}":/ /tmp/efs
mkdir -p /tmp/efs/data
mkdir -p /tmp/efs/cache
mkdir -p /tmp/efs/temp

umount /tmp/efs


#Mount shared storage
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 "${efs_address}":/data /var/www/moodle/data
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 "${efs_address}":/cache /var/www/moodle/cache
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 "${efs_address}":/temp /var/www/moodle/temp

#install ansible
amazon-linux-extras install ansible2 -y

#configure ansible hosts file to localhost
echo "localhost ansible_connection=local ansible_python_interpreter=/usr/bin/python ansible_user=ec2-user ansible_become=true" >> /etc/ansible/hosts


