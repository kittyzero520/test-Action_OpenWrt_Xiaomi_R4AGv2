#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改默认LAN IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 移除冲突的 dnsmasq 包
sed -i '/CONFIG_PACKAGE_dnsmasq=y/d' .config

# 确保使用 dnsmasq-full（注意：删除名称中的空格）
if ! grep -q 'CONFIG_PACKAGE_dnsmasq-full=y' .config; then
    echo 'CONFIG_PACKAGE_dnsmasq-full=y' >> .config
fi  # 添加 fi 闭合 if 语句

# 打印配置验证结果（可选，用于调试）
echo "===== dnsmasq 配置状态 ====="
grep -E 'CONFIG_PACKAGE_(dnsmasq|dnsmasq-full)=y' .config
echo "=========================="

# 以下是还原设备名称相关的修改
# 1. 还原固件版本及版权信息
# sed -i's/LEDE R.*/LEDE R25.5.25 openwrt - 23.05 by kittyzero/g' package/lean/default - settings/files/zzz - default - settings
# sed -i's/OpenWrt 24.10.1/LEDE R25.5.25 openwrt - 23.05 by kittyzero/g' package/lean/default - settings/files/zzz - default - settings

# 2. 还原LuCI底部版权信息
# sed -i's/Powered by LuCI.*/Powered by LEDE R25.5.25 openwrt - 23.05 by kittyzero/g' package/lean/luci - mod - system/htdocs/luci - static/resources/view/system/status.js

# 3. 还原主机名（默认LEDE改为Xiaomi）
# sed -i's/hostname=.*$/hostname="Xiaomi"/g' package/base - files/files/bin/config_generate

# 4. 还原设备型号（ADSLR G7改为小米路由器4A千兆版v2）
# sed -i's/ADSLR G7/Xiaomi Mi Router 4A Gigabit Edition v2/g' target/linux/ramips/dts/mt7621_xiaomi_mir3g - v2.dts
# sed -i's/ADSLR G7/Xiaomi Mi Router 4A Gigabit Edition v2/g' target/linux/ramips/image/mt7621.mk

# 5. 还原编译配置中的设备标识
# sed -i's/adslr_g7/xiaomi_mir3g - v2/g' target/linux/ramips/image/mt7621.mk

# 6. 还原.config中的设备配置（如果需要）
# sed -i's/CONFIG_TARGET_DEVICE_ramips_mt7621_DEVICE_adslr_g7=y/CONFIG_TARGET_DEVICE_ramips_mt7621_DEVICE_xiaomi_mir3g - v2=y/g' .config
