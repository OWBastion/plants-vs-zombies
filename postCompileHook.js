// postCompileHook.js
// 黑影重做后「黑客入侵」更名为「在线修复」, overpy 词表仍输出旧名。冷却时间的新名按其他技能的命名规律推得, 未经客户端确认。
content = content.replace(/黑客入侵冷却时间/g, "在线修复冷却时间");
content;
