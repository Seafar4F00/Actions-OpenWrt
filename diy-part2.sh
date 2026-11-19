#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
# Fix ARRIS SBR-AC1750 5G WiFi caldata extraction permanently
mkdir -p package/base-files/files/etc/hotplug.d/firmware
cat << 'EOF' > package/base-files/files/etc/hotplug.d/firmware/10-arris-caldata
#!/bin/sh
[ -e /lib/firmware/$FIRMWARE ] && exit 0
. /lib/functions/caldata.sh
case "$FIRMWARE" in
"ath10k/cal-pci-0000:00:00.0.bin")
    case "$(board_name)" in
    arris,sbr-ac1750)
        caldata_extract "caldata" 0x5000 0x844
        ;;
    esac
    ;;
esac
EOF
