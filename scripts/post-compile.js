// 编译后处理: 修正 wright 0.43.1 zh-CN 输出的词表问题。上游修复后删除对应条目。
// 用法: node scripts/post-compile.js <编译输出路径>
const fs = require("fs");
const path = process.argv[2];

const renames = [
    // 英文设置键 (opy-rs#723), 译名取自 OverPy 9.7.9 的 zh-CN 输出
    [/^(\s*)drawTime: /gm, "$1无目标点决胜机制时平局时限: "],
    [/^(\s*)enableWallhack: true$/gm, "$1显示英雄位置: 开启"],
    [/^(\s*)enableWallhack: false$/gm, "$1显示英雄位置: 关闭"],
    [/^(\s*)wallhackEnabledTime: /gm, "$1比赛开始后显示英雄位置时间: "],
    [/^(\s*)enableTiebreaker: true$/gm, "$1目标点决胜机制: 开启"],
    [/^(\s*)enableTiebreaker: false$/gm, "$1目标点决胜机制: 关闭"],
    [/^(\s*)tiebreakerTime: /gm, "$1目标点决胜机制激活时间: "],
    [/^(\s*)secondaryFireRechargeRate%: /gm, "$1呼吸器充能速度: "],
    [/^(\s*)secondaryFireMaximumTime%: /gm, "$1呼吸器最长时间: "],
    // 黑影重做后「黑客入侵」更名为「在线修复」 (workshop-rs#617)。冷却时间的新名按其他技能的命名规律推得, 未经客户端确认。
    [/黑客入侵冷却时间/g, "在线修复冷却时间"],
];

let content = fs.readFileSync(path, "utf8");
for (const [from, to] of renames) {
    content = content.replace(from, to);
}
fs.writeFileSync(path, content);
