// postCompileHook.js
// wright 在设置名本地化之前执行本脚本, 所以这里看到的是英文设置名, 英文键的值也不带单位。
// wright 0.43.1 缺少下列设置的 zh-CN 名: 直接写成客户端接受的中文键, wright 会原样输出。
const renames = [
    // 英文设置键 (opy-rs#723), 译名取自 OverPy 9.7.9 的 zh-CN 输出
    [/^(\s*)drawTime: /gm, "$1无目标点决胜机制时平局时限: "],
    [/^(\s*)enableWallhack: true$/gm, "$1显示英雄位置: 开启"],
    [/^(\s*)enableWallhack: false$/gm, "$1显示英雄位置: 关闭"],
    [/^(\s*)wallhackEnabledTime: /gm, "$1比赛开始后显示英雄位置时间: "],
    [/^(\s*)enableTiebreaker: true$/gm, "$1目标点决胜机制: 开启"],
    [/^(\s*)enableTiebreaker: false$/gm, "$1目标点决胜机制: 关闭"],
    [/^(\s*)tiebreakerTime: /gm, "$1目标点决胜机制激活时间: "],
    [/^(\s*)secondaryFireRechargeRate%: (\S+)$/gm, "$1呼吸器充能速度: $2%"],
    [/^(\s*)secondaryFireMaximumTime%: (\S+)$/gm, "$1呼吸器最长时间: $2%"],
    // 黑影重做后「黑客入侵」更名为「在线修复」 (workshop-rs#617)。冷却时间的新名按其他技能的命名规律推得, 未经客户端确认。
    [/^(\s*)Hack Cooldown Time: /gm, "$1在线修复冷却时间: "],
];
for (const [from, to] of renames) {
    content = content.replace(from, to);
}
content;
