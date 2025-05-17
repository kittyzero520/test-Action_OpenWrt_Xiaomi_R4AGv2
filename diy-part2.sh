#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# ======================
# 原有 dnsmasq 配置逻辑
# ======================
# 移除冲突的 dnsmasq 包
sed -i '/CONFIG_PACKAGE_dnsmasq=y/d' .config

# 修改默认LAN IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 确保使用 dnsmasq-full（避免重复添加）
if ! grep -q 'CONFIG_PACKAGE_dnsmasq-full=y' .config; then
  echo 'CONFIG_PACKAGE_dnsmasq-full=y' >> .config
fi

# 打印配置验证结果（可选，用于调试）
echo "===== dnsmasq 配置状态 ====="
grep -E 'CONFIG_PACKAGE_(dnsmasq|dnsmasq-full)=y' .config
echo "=========================="

# ======================
# 新增：固件信息修改
# ======================
# 1. 修改固件版本及版权信息
sed -i 's/LEDE R.*/LEDE R25.5.25 openwrt-23.05 by kittyzero/g' package/lean/default-settings/files/zzz-default-settings
sed -i 's/OpenWrt 24.10.1/LEDE R25.5.25 openwrt-23.05 by kittyzero/g' package/lean/default-settings/files/zzz-default-settings

# 2. 修改LuCI底部版权信息
sed -i 's/Powered by LuCI.*/Powered by LEDE R25.5.25 openwrt-23.05 by kittyzero/g' package/lean/luci-mod-system/htdocs/luci-static/resources/view/system/status.js

# 3. 修改主机名（默认LEDE改为Xiaomi）
sed -i 's/hostname=.*$/hostname="Xiaomi"/g' package/base-files/files/bin/config_generate

# 4. 修改设备型号（ADSLR G7改为小米路由器4A千兆版v2）
# 注意：请根据实际设备DTS文件路径调整，以下为常见路径示例
sed -i 's/ADSLR G7/Xiaomi Mi Router 4A Gigabit Edition v2/g' target/linux/ramips/dts/mt7621_xiaomi_mir3g-v2.dts
sed -i 's/ADSLR G7/Xiaomi Mi Router 4A Gigabit Edition v2/g' target/linux/ramips/image/mt7621.mk


