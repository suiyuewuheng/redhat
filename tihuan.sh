#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script"
    exit 1
fi

clear
echo "========================================================================="
echo "Replace Redhat Enterprise Yum to CentOS Yum and Repos,  Written by Licess"
echo "========================================================================="



# uninstall rhel yum 
echo "Uninstall Rhel Yum......"
rpm -qa|grep yum|xargs rpm -e --nodeps
# delete old rpm
echo "Clean old cache......"
rm -rf python-iniparse-0.3.1-2.1.el6.noarch.rpm
rm -rf yum-metadata-parser-1.1.2-16.el6.x86_64.rpm
rm -rf yum-3.2.29-81.el6.centos.noarch.rpm
rm -rf yum-plugin-fastestmirror-1.1.30-41.el6.noarch.rpm
rm -rf python-urlgrabber-3.9.1-11.el6.noarch.rpm

# download CentOS Yum
echo "Download Python-iniparse......"
wget http://mirrors.163.com/centos/6/os/x86_64/Packages/python-iniparse-0.3.1-2.1.el6.noarch.rpm

echo "Download yum-metadata-parse......"
wget http://mirrors.163.com/centos/6/os/x86_64/Packages/yum-metadata-parser-1.1.2-16.el6.x86_64.rpm

echo "Download yum......"
wget http://mirrors.163.com/centos/6/os/x86_64/Packages/yum-3.2.29-81.el6.centos.noarch.rpm

echo "Download yum fastmirror......"
wget http://mirrors.163.com/centos/6/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.30-41.el6.noarch.rpm

echo "dependences for pyrhon........"
wget http://mirrors.163.com/centos/6/os/x86_64/Packages/python-urlgrabber-3.9.1-11.el6.noarch.rpm
# install CentOS Yum
echo "Installing......"
rpm -e python-urlgrabber-3.9.1-9.el6.noarch
rpm -ivh python-urlgrabber-3.9.1-11.el6.noarch.rpm
rpm -ivh  python-iniparse-0.3.1-2.1.el6.noarch.rpm
rpm -ivh  yum-metadata-parser-1.1.2-16.el6.x86_64.rpm
rpm -ivh  yum-3.2.29-81.el6.centos.noarch.rpm yum-plugin-fastestmirror-1.1.30-41.el6.noarch.rpm

# replace repos
rm -rf /etc/yum.repos.d/CentOS-Base.repo
echo "[base]
name=CentOS-6 - Base - 163.com
baseurl=http://mirrors.163.com/centos/6/os/x86_64/
#mirrorlist=http://mirrors.163.com/?release=6&arch=$basearch&repo=os
gpgcheck=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-6

#released updates 
[updates]
name=CentOS-6 - Updates - 163.com
baseurl=http://mirrors.163.com/centos/6/updates/x86_64/
#mirrorlist=http://mirrors.163.com/?release=6&arch=$basearch&repo=updates
gpgcheck=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-6

#additional packages that may be useful
[extras]
name=CentOS-6 - Extras - 163.com
baseurl=http://mirrors.163.com/centos/6/extras/x86_64/
#mirrorlist=http://mirrors.163.com/?release=6&arch=$basearch&repo=extras
gpgcheck=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-6

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-6 - Plus - 163.com
baseurl=http://mirrors.163.com/centos/6/centosplus/x86_64/
#mirrorlist=http://mirrors.163.com/?release=6&arch=$basearch&repo=centosplus
gpgcheck=1
enabled=0
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-6

#contrib - packages by Centos Users
[contrib]
name=CentOS-6 - Contrib - 163.com
baseurl=http://mirrors.163.com/centos/6/contrib/x86_64/
#mirrorlist=http://mirrors.163.com/?release=6&arch=$basearch&repo=contrib
gpgcheck=1
enabled=0
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-6" >> /etc/yum.repos.d/CentOS-Base.repo

#####
yum clean all
yum makecache
yum update



echo "=========================================================================="
echo "You have successfully replace RedhatEnterprise Yum to CentOS yum and repos"
echo "=========================================================================="
