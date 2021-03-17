# 0. Prerequisites
    sudo apt update
    sudo apt install build-essential ccache ecj fastjar file g++ gawk \
    gettext git java-propose-classpath libelf-dev libncurses5-dev \
    libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget \
    python3-distutils python3-setuptools rsync subversion swig time \
    xsltproc zlib1g-dev 

P.S. No need to install Golang

# 1. Clone openwrt from lean (openwrt source has compatibility issues with themes)
    (no good)git clone -b openwrt-19.07 https://github.com/shawhu/openwrt openwrt
    git clone https://github.com/coolsnowwolf/lede openwrt
    cd openwrt
# 2. Add dependencies
    cd package
    git clone https://github.com/shawhu/openwrt-passwall shawhu
    
# 3. Update feeds
    ./scripts/feeds update -a
    ./scripts/feeds install -a

# 4. make some changes (if using openwrt official repo)
- update go to 1.15

    [openwrt_sdk_folder]/feeds/packages/lang/golang/golang-version.mk
    -----------------------------------------------------------------
    GO_VERSION_MAJOR_MINOR:=1.15 (将此字段修改为1.15)
    GO_VERSION_PATCH:=8 (将此字段修改为8)

    [openwrt_sdk_folder]/feeds/packages/lang/golang/golang/Makefile
    ---------------------------------------------------------------
    PKG_SOURCE:=go$(PKG_VERSION).src.tar.gz
    PKG_SOURCE_URL:=$(GO_SOURCE_URLS)
    PKG_HASH:=540c0ab7781084d124991321ed1458e479982de94454a98afab6acadf38497c2 (将此字段修改为golang 15.8的源码hash值)


- Add upx

execute addupx.sh

And update the feeds again
    ./scripts/feeds update -a
    ./scripts/feeds install -a



# 5 Download stuff
    make -j8 download

# 6 Generate config
make menuconfig
add luci-app-xxxxx
check network/xxxxx
remove base/dnsmask and choose dnsmaskfull


# 7 Make
    make -j1 V=s
    
the final image is in bin/X86/xxxx folder
initial ip is 192.168.17.234, and it binds eth0 (the first port on the left or right)
initial password: password

# Others

- add diskman

    mkdir -p package/luci-app-diskman && \
    wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/applications/luci-app-diskman/Makefile -O package/luci-app-diskman/Makefile
    mkdir -p package/parted && \
    wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Parted.Makefile -O package/parted/Makefile

    #compile package only
    make package/luci-app-diskman/compile V=99
    
    #compile
    make menuconfig
    #choose LuCI ---> 3. Applications  ---> <*> luci-app-diskman..... Disk Manager interface for LuCI ----> save
    make V=99
    




