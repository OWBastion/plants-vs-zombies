const fs = require("node:fs");

const files = [
    ["src/main.opy", /最后更新\| v(\d{2,4}\.\d{4}\.\d+)/g],
    ["src/ui/hud.opy", /(?<=#!define MODE_VERSION ")v(\d{2,4}\.\d{4}\.\d+)(?=")/g],
];
const sources = files.map(([path, pattern]) => {
    const source = fs.readFileSync(path, "utf8");
    const matches = [...source.matchAll(pattern)];
    if (matches.length !== 1) throw new Error(`Expected one version in ${path}`);
    return { path, pattern, source, version: matches[0][1] };
});
if (sources[0].version !== sources[1].version) throw new Error("Mode description and HUD versions differ");
const now = new Date();
const date = `${String(now.getFullYear()).slice(-2)}.${String(now.getMonth() + 1).padStart(2, "0")}${String(now.getDate()).padStart(2, "0")}`;
const [year, monthDay, count] = sources[0].version.split(".");
const next = `${date}.${year.slice(-2) + "." + monthDay === date ? Number(count) + 1 : 1}`;
for (const { path, pattern, source } of sources) {
    fs.writeFileSync(path, source.replace(pattern, (match) => match.replace(sources[0].version, next)));
}
console.log(`${sources[0].version} -> ${next}`);
