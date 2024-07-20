#!/bin/bash

# Initialization environment
sudo rm -rf /etc/apt/sources.list.d/* /usr/share/dotnet /usr/local/lib/android /opt/ghc
sudo -E apt-get -qq update
sudo -E apt-get -qq install ack antlr3 aria2 asciidoc autoconf automake autopoint binutils bison build-essential bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 python3-pip libpython3-dev qemu-utils rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev
sudo -E apt-get -qq autoremove --purge
sudo -E apt-get -qq clean
sudo timedatectl set-timezone "Asia/Shanghai"
sudo mkdir -p /mnt/workdir
sudo chown $USER:$GROUPS /mnt/workdir

# Clone source code
cd /mnt/workdir
df -hT $PWD
git clone https://github.com/coolsnowwolf/lede -b master openwrt

# Load custom feeds
cd openwrt
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
echo 'src-git huashengke https://github.com/Lintao-Zeng/huashengke' >>feeds.conf.default

# Update feeds
./scripts/feeds update -a

# Install feeds
./scripts/feeds install -a

# Check end and run next steps
echo "Please continue manually: $PWD"
while :
do
    if [ -f end.txt ] 
    then
        break
    fi
    sleep 3
done

# Modify default IP
# sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Download package
make defconfig
make download -j8
find dl -size -1024c -exec ls -l {} \;
find dl -size -1024c -exec rm -f {} \;

# Compile the firmware
make -j$(nproc) || make -j1 || make -j1 V=s

# firmware path
cd openwrt/bin/targets/*/*
pwd
