// postCompileHook.js
// overpy 9.7.9 的 zh-CN 数据中 ChaseTimeReeval/ChaseRateReeval 的 "None" 枚举值是过期的
// 「全部禁用」，而当前游戏客户端导出/接受的是「无」。这里只在 chase 函数调用行内把
// 「全部禁用」替换回「无」，避免误伤设置区里其他合法的「全部禁用」取值。
content = content.split("\n").map((line) =>
    (line.includes("持续追踪全局变量") || line.includes("追踪玩家变量频率"))
        ? line.replace("全部禁用", "无")
        : line
).join("\n");
content;
