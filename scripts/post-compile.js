// wright 的 zh-CN 输出沿用了 chase 枚举的过期值「全部禁用」, 这里复用 postCompileHook.js 的定点替换。
const fs = require("fs");
const path = process.argv[2];
let content = fs.readFileSync(path, "utf8");
content = eval(fs.readFileSync(`${__dirname}/../postCompileHook.js`, "utf8"));
fs.writeFileSync(path, content);
