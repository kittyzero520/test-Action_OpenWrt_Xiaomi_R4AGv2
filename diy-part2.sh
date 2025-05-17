#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 移除冲突的 dnsmasq 包
sed -i '/CONFIG_PACKAGE_dnsmasq=y/d' .config

# 确保使用 dnsmasq-full（避免重复添加）
if ! grep -q 'CONFIG_PACKAGE_dnsmasq-full=y' .config; then
  echo 'CONFIG_PACKAGE_dnsmasq-full=y' >> .config
fi

# 打印配置验证结果（可选，用于调试）
echo "===== dnsmasq 配置状态 ====="
grep -E 'CONFIG_PACKAGE_(dnsmasq|dnsmasq-full)=y' .config
echo "=========================="
