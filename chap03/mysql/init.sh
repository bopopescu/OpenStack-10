#!/bin/bash
set -e                                                                  #set -e 表示一旦脚本运行错误就报错并停止执行余下命令
set -o xtrace

TOP_DIR=$(cd $(dirname "$0") && pwd)
TEMP=`mktemp`; rm -rfv $TEMP >/dev/null; mkdir -p $TEMP;
DEST=/opt/stack
source $TOP_DIR/tools/function
cp -rf $TOP_DIR/`ls -l $TOP_DIR/localrc | awk '{print $11}'` /root/
#---------------------------------------------
# Check for apt.
#---------------------------------------------
DEBIAN_FRONTEND=noninteractive \
apt-get --option \
"Dpkg::Options::=--force-confold" --assume-yes \
install -y --force-yes openssh-server 
#---------------------------------------------
# Kill process by Name
#---------------------------------------------

cp -rf $TOP_DIR/tools/nkill /usr/bin/
chmod +x /usr/bin/nkill

#---------------------------------------------
# Set up iptables.
#---------------------------------------------

setup_iptables

set +o xtrace
