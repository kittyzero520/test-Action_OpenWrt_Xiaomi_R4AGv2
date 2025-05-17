**中文** 

openwrt-builder.yml
此文件的主要作用是运用 GitHub Actions 构建 OpenWrt 固件。以下是文件的主要部分及其功能：
触发条件
yaml
on:
  repository_dispatch:
  workflow_dispatch:

该工作流能够通过repository_dispatch事件或者手动触发（workflow_dispatch）来启动。
环境变量
yaml
env:
  REPO_URL: https://github.com/coolsnowwolf/lede
  REPO_BRANCH: master
  FEEDS_CONF: feeds.conf.default
  CONFIG_FILE: .config
  DIY_P1_SH: diy-part1.sh
  DIY_P2_SH: diy-part2.sh
  UPLOAD_BIN_DIR: false
  UPLOAD_FIRMWARE: true
  UPLOAD_RELEASE: true
  TZ: Asia/Shanghai

这些环境变量对源代码仓库、配置文件、自定义脚本以及上传选项等信息进行了定义。
工作步骤
环境初始化：安装编译所需的依赖包并进行系统配置。
克隆源代码：从指定的仓库克隆 OpenWrt 源代码。
加载自定义源：运行diy-part1.sh脚本以添加自定义源。
更新和安装源：更新软件源并安装所有必要的包。
加载自定义配置：将.config文件复制到 OpenWrt 目录，并运行diy-part2.sh脚本。
下载包：下载编译所需的所有包。
编译固件：开始编译固件。
上传结果：将编译好的固件上传到 GitHub Actions 的 Artifacts 和 Release 中。
update-checker.yml
这个文件的主要功能是检查 OpenWrt 源代码是否有更新，若有更新则触发固件构建。以下是文件的主要部分及其功能：
触发条件
yaml
on:
  workflow_dispatch:
#  schedule:
#    - cron: 0 */18 * * *

该工作流能够通过手动触发（workflow_dispatch）来启动，也可以按照指定的时间表（注释部分）定时执行。
环境变量
yaml
env:
  REPO_URL: https://github.com/coolsnowwolf/lede
  REPO_BRANCH: master

这些环境变量对源代码仓库和分支信息进行了定义。
工作步骤
获取提交哈希：克隆源代码仓库并获取最新的提交哈希。
比较提交哈希：利用actions/cache来比较当前的提交哈希和之前缓存的哈希。
保存新的提交哈希：若有新的提交，则保存新的哈希。
触发构建：若有新的提交，则触发Source Code Update事件以启动固件构建。
使用方法
手动触发构建：
前往 GitHub 仓库的Actions页面。
选择OpenWrt Builder工作流。
点击Run workflow按钮来启动固件构建。
自动检查更新并构建：
取消update-checker.yml文件中schedule部分的注释，设置检查更新的时间表。
当检测到源代码有更新时，会自动触发固件构建。
注意事项
要保证.config文件存在于仓库的根目录，或者根据需要修改CONFIG_FILE环境变量。
可以通过编辑diy-part1.sh和diy-part2.sh脚本来对编译过程进行自定义。
若需要更多自定义选项，可以对环境变量和脚本进行修改。
