#!/bin/sh
# 导入工具: 把游戏内导出的 .ow 反编译回 src/main.opy
# 用法: pnpm run decompile <导出的.ow路径>  (pnpm 不加 --; npm 需 npm run decompile -- <file>)
set -e

if [ -z "$1" ]; then
    echo "用法: pnpm run decompile -- <导出的.ow 路径>" >&2
    exit 1
fi

# overpy 9.7.9 的 ChaseTimeReeval/ChaseRateReeval "None" 中文值是过期的「全部禁用」,
# 游戏客户端导出的是「无」;仅在 chase 调用处替换,让反编译能识别该枚举。
sed 's/, 无);/, 全部禁用);/g' "$1" \
    | ./node_modules/.bin/overpy decompile -l zh-CN \
    > /tmp/pvz2.decompiled.opy

# 恢复 overpy 过旧 include/exclude 列表静默丢弃的设置,并追加 #!postCompileHook 指令。
# 注意: 反编译产出是单文件,会覆盖 src/main.opy,模块拆分需在导入后重新进行。
python3 scripts/fix-pvz2-decompiled.py /tmp/pvz2.decompiled.opy src/main.opy
