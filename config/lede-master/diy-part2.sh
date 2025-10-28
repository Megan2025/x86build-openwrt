#!/bin/bash
#========================================================================================================================
# Description: Automatically Build OpenWrt for Amlogic s9xxx or x86_64 devices
# Function: Diy script (After Update feeds, Modify default IP, hostname, theme, add/remove software packages, etc.)
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# Modify default theme
# sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Add autocore support for armvirt
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings
echo "DISTRIB_SOURCECODE='openwrt'" >> package/base-files/files/etc/openwrt_release

# Modify default IP
# sed -i 's/192.168.1.1/192.168.31.4/g' package/base-files/files/bin/config_generate

# ------------------------------- Main source ends -------------------------------


# ------------------------------- Other started -------------------------------
#
# ✅ Fix: luci-app-amlogic should be cloned via git, not svn
rm -rf package/luci-app-amlogic
git clone https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic

# 如果 GitHub 访问较慢，可以换镜像
# git clone https://mirror.ghproxy.com/https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic

# ------------------------------- Other ends -------------------------------
