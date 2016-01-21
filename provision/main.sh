#!/usr/bin/env bash
##########################
#   Valeriy Solovyov < weldpua2008@gmail.com>
#   version 0.1 <21.1.2016>
#       - initial add puppet provisioning on CentOS
#########################
SOURCE="${BASH_SOURCE[0]}"
RDIR="$( dirname "$SOURCE" )"

ON_CENTOS(){
    CENTOS_RELEASE=$(rpm -qa \*-release | grep -Ei "oracle|redhat|centos" | cut -d"-" -f3)
    sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-${CENTOS_RELEASE}.noarch.rpm
    sudo yum install puppet -y

    exit 0
}
ON_DEBIAN(){
    echo ""
    exit 0
}
ON_SUSE(){
    RELEASE=$(python -c "import platform;distname,version,id=platform.linux_distribution();print id")
    wget https://apt.puppetlabs.com/puppetlabs-release-${RELEASE}.deb
    sudo dpkg -i puppetlabs-release-pc1-wheezy.deb
    sudo apt-get update
    sudo apt-get install puppet-agent -y
    exit 0
}

 which yum && ON_CENTOS
 which zypper && ON_SUSE
 which apt-get && ON_DEBIAN
