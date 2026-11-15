// postCompileHook.js
// overpy 9.7.9 的 zh-CN 数据中 ChaseTimeReeval/ChaseRateReeval 的 "None" 枚举值是过期的
// 「全部禁用」，而当前游戏客户端导出/接受的是「无」。这里只在 chase 函数调用行内把
// 「全部禁用」替换回「无」，避免误伤设置区里其他合法的「全部禁用」取值。
content = content.split("\n").map((line) =>
    (line.includes("持续追踪全局变量") || line.includes("追踪玩家变量频率"))
        ? line.replace("全部禁用", "无")
        : line
).join("\n");
// 黑影重做后「黑客入侵」更名为「在线修复」, overpy 词表仍输出旧名。冷却时间的新名按其他技能的命名规律推得, 未经客户端确认。
content = content.replace(/黑客入侵冷却时间/g, "在线修复冷却时间");
content;
