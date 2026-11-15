// 编译后对最终文本的修正。用法: node scripts/post-compile.js <编译输出路径>
// wright 0.43.1 把 chase 全局变量动作的变量参数输出成「全局.变量名」, 客户端只接受裸变量名 (workshop-rs#620, 修复后删除本脚本)。
// #!postCompileHook 在 wright 重新解析之前运行, 前缀会被再次加上, 所以只能在这里处理。
const fs = require("fs");
const path = process.argv[2];
const content = fs.readFileSync(path, "utf8").replace(/(持续追踪全局变量\()全局\./g, "$1");
fs.writeFileSync(path, content);
