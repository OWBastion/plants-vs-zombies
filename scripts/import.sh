#!/bin/sh
# 导入工具: 把游戏内导出的 .ow 反编译回 src/main.opy
# 用法: pnpm run decompile <导出的.ow路径>  (pnpm 不加 --; npm 需 npm run decompile -- <file>)
set -e

if [ -z "$1" ]; then
    echo "用法: pnpm run decompile -- <导出的.ow 路径>" >&2
    exit 1
fi

# overpy 9.7.9 的 ChaseTimeReeval/ChaseRateReeval "None" 中文值是「全部禁用」。
# 旧版客户端导出「无」,当前客户端导出「全部禁用」;下面仅在 chase 调用处替换旧导出,对新导出无影响。
sed 's/, 无);/, 全部禁用);/g' "$1" \
    | ./node_modules/.bin/overpy decompile -l zh-CN \
    > /tmp/pvz2.decompiled.opy

# 恢复 overpy 过旧 include/exclude 列表静默丢弃的设置。
# 注意: 反编译产出是单文件,会覆盖 src/main.opy,模块拆分需在导入后重新进行。
python3 scripts/fix-pvz2-decompiled.py /tmp/pvz2.decompiled.opy src/main.opy
