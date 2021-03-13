# 0 Prerequisites

No need to install Golang

# 1. Clone openwrt
    git clone https://github.com/shawhu/openwrt/tree/openwrt-19.07 openwrt
    cd openwrt

# 2. Update feeds
    ./scripts/feeds update -a
    ./scripts/feeds install -a

# 3. Add dependencies
    cd openwrt/package
    git clone https://github.com/shawhu/openwrt-passwall shawhu

# 4. make some changes
update go to 1.15

    [openwrt_sdk_folder]/feeds/packages/lang/golang/golang-version.mk
    -----------------------------------------------------------------
    GO_VERSION_MAJOR_MINOR:=1.15 (将此字段修改为1.15)
    GO_VERSION_PATCH:=8 (将此字段修改为8)

    [openwrt_sdk_folder]/feeds/packages/lang/golang/golang/Makefile
    ---------------------------------------------------------------
    PKG_SOURCE:=go$(PKG_VERSION).src.tar.gz
    PKG_SOURCE_URL:=$(GO_SOURCE_URLS)
    PKG_HASH:=540c0ab7781084d124991321ed1458e479982de94454a98afab6acadf38497c2 (将此字段修改为golang 15.8的源码hash值)


add upx
execute addupx.sh

And update the feeds again
    ./scripts/feeds update -a
    ./scripts/feeds install -a



# 5 Download stuff
    make -j8 download

# 6 generate config
make menuconfig
add luci-app-xxxxx
check network/xxxxx
remove base/dnsmask and choose dnsmaskfull


# 7 make
    make -j1 V=s




