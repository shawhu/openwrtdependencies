mkdir -p tools/ucl && wget -P tools/ucl https://raw.githubusercontent.com/coolsnowwolf/lede/master/tools/ucl/Makefile
mkdir -p tools/upx && wget -P tools/upx https://raw.githubusercontent.com/coolsnowwolf/lede/master/tools/upx/Makefile
sed -i '/tools-$(CONFIG_TARGET_orion_generic)/atools-y += ucl upx' tools/Makefile
sed -i '/dependencies/a\$(curdir)/upx/compile := $(curdir)/ucl/compile' tools/Makefile
