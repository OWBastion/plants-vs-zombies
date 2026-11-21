# 费斯卡科技：近战与前排（v12，已落地）

状态：**已在代码中实现**，`pnpm run compile` 结果为 `errors=0`。编号 43–52，与 `Tech_Id` 和 `Upgrade_Catalog` 的末尾 10 行一一对齐。编译通过不等于游戏内验证，第七节列了必须实测的项。

**当前可用 8 项**：坚定（43）与痛苦疗愈（44）`enabled=0`，共用池表已重做可用，缺的是这两项的规则体，见第四节。

## 一、10 项科技

| 编号 | 名称       | 文件                         | 效果                                          |
| -- | -------- | -------------------------- | ------------------------------------------- |
| 43 | 坚定〔暂停〕 | `tech/steadfast.opy` | 受到伤害时获得 12% 最大生命值的临时护甲，最多 5 层，每层独立 5 秒 |
| 44 | 痛苦疗愈〔暂停〕 | `tech/painful_healing.opy` | 受到伤害的 12% 转换为临时生命值，8 秒后移除 |
| 45 | 不屈意志     | `tech/indomitable.opy`     | 每损失 1% 最大生命，获得 1% 减伤与 1% 增伤                 |
| 46 | 坚韧       | `tech/resolute.opy`        | 受到伤害后 4 秒内受到的伤害降低 40%                       |
| 47 | 大运来咯     | `tech/knockdown.opy`       | 你造成的击退会将敌人击倒 1 秒                            |
| 48 | 银质子弹     | `tech/silver_bullet.opy`   | 弹匣最后一枚子弹额外造成 250% 伤害                        |
| 49 | 佛法自然〔唯一〕 | `tech/dharma.opy`          | 15 米内的僵尸受到的伤害增加 25%                         |
| 50 | 亡语       | `tech/death_rattle.opy`    | 阵亡后爆炸，25 米内敌人受到你 50% 最大生命值的伤害               |
| 51 | 屹立不倒     | `tech/unyielding.opy`      | 每损失 1% 最大生命，获得 1% 全能吸血，不封顶                  |
| 52 | 死亡之舞     | `tech/death_dance.opy`     | 受到伤害的 50% 在 2 秒内以流血扣除；击杀回复 25～75 + 5% 最大生命值 |

两条本轮新定的口径：死亡之舞的 25～75 **按进攻波次线性插值**（`feskaGrowthAt(progress, 25, 50)`）；银质子弹**判第 0 个弹夹**（`getAmmo(0) == 0`），并且**只发给带弹夹的英雄**——选牌池里按 `getMaxAmmo(0) > 0` 过滤，见第六节。

## 二、地基一：受击口径 `attack·er != null`

脚本流血与自损的 `attacker` 为 `null`，会被“受到伤害时”类科技当成一次正常受击。所有受击触发统一要求 `attacker != null`：

| 文件                  | 改动                                                           |
| ------------------- | ------------------------------------------------------------ |
| `tech/crusader.opy` | 新增 `attacker != null`，保留 `attacker != eventPlayer` 继续排除狂战士自损 |
| `tech/thorns.opy`   | 新增 `attacker != null`，不再依赖在 `null` 上调用 `getTeam()`           |
| `tech/reactive.opy` | 原本已有，不改                                                      |
| 新增的坚定、痛苦疗愈、坚韧、死亡之舞  | 直接写这条条件                                                      |

## 三、地基二：减伤加算，总和封顶 90%

```
#!define feskaReceivedPercent(p) (100 - min(p.Bonus_By_Stat[Stat_Bonus.DAMAGE_REDUCTION] + (15 if p.Is_Alone else 0) + (40 if p.Is_Resolute else 0) + p.Missing_Health_Percent, 90))
```

- 一夫当关的 `×0.85` 改成加算 15 并入总和。
- 属性强化·减伤原来单项夹在 50%，现在只累加，由总和上限兜住。
- 不屈意志与坚韧都进这个总和，因此“残血 + 坚韧 + 一夫当关”不会各自夹取上限后绕过封顶。

不屈意志的增伤走另一条宏：`feskaDamagePercent` 加上 `Missing_Health_Percent`，不封顶。

缺失生命的口径是 `100 - 100 × getHealth() / feskaMaxHealth`，生命池挡下的伤害不算失血，因此不会“被护盾打反而增伤”。

## 四、地基三：共用临时生命池表（已重做）

上一版把根因判成“参数来自全局变量”，**这个结论是错的**：数量与到期时间一直走全局变量，现在也照旧走全局变量且工作正常。真正错的是子程序自己的两处写法。

### 错误一：Health Type 被变量化

```
为玩家添加生命池(全局.Target_Player, 全局.Temp_Pool_Type, 全局.Temp_Pool_Amount, 真, 假)
```

`Add Health Pool` 的 Health Type 是**枚举常量槽**，只接受字面量（`护盾` / `护甲` / `生命值`）。传变量时 OverPy 只校验“它是数字”，编译能过，但生成的动作在游戏里类型槽是空的，池加不上并连带规则卡住。同一个参数位在可用版本里放的是 `ceil(...)` 表达式（数量），说明该位置只受表达式、不受枚举变量，所以差异确实只在类型这一项。

重做后由 `feskaAddTempPool` 按标签分派，五个分支各自写内联字面量：

```
if Temp_Pool_Tag == Temp_Pool_Id.SHIELD:      addHealthPool(Health.SHIELDS, ...)
elif Temp_Pool_Tag == Temp_Pool_Id.REACTIVE:  addHealthPool(Health.ARMOR, ...)
...
```

`Temp_Pool_Type` 这个全局量已删除——留着它就会有人再想往枚举槽里塞变量。**新增标签必须补一支分支**，漏配时 `getLastCreatedHealthPool()` 会拿到上一个池。

### 错误二：子程序复用了调用方的循环变量

旧 `feskaClearTempPoolsByTag` / `feskaClearAllTempPools` 内部用全局 `Loop_Index` 遍历池表，而调用方 `feskaRefreshShields`、离场清理本身也在用 `Loop_Index` 遍历玩家。子程序一进循环就把外层计数改掉，外层只剩第一个玩家被处理，后续玩家漏处理甚至越界——这可能才是“偶尔卡住”的直接来源。

池表子程序现在统一用专用的 `Pool_Index`，与业务循环彻底分开；`Loop_Index` 只给规则自己的循环用。

### 重做后的形态

| 位置 | 现状 |
| --- | --- |
| `pools.opy` | `feskaAddTempPool`（按标签分派后建池并记账）、`feskaClearTempPoolsByTag`、`feskaClearAllTempPools`、四个 Apply 子程序 |
| 光子护盾、血肉再生、反应装甲 | 回归共用表，各自先按标签清旧记录再整池重建，参数经全局变量传入 |
| 护甲强化、心之钢 | 仍各自持句柄（`Armor_Health_Pool` / `Heartsteel_Health_Pool`），来源唯一、单句柄够用 |
| 表结构 | `Temp_Pool_Ids` / `Temp_Pool_Handles` / `Temp_Pool_Expire_At` 三张平行数组，到期时间 0 表示不按时间到期 |
| 到期 | `Feska - Temp pool expiry` 每 0.25 秒逐条移除到期记录 |

坚定（43）与痛苦疗愈（44）仍然 `enabled=0`：共用表现在能用了，但这两项的规则体还没写。重做时的约束不变：

1. **坚定每层必须单独建池并单独到期**。整池重建会把已经吸收掉的护甲补回来。
2. **痛苦疗愈要封顶同时存在的记录数**。高攻速受击会把玩家身上的池数量堆到不可控。
3. 两者都用 `feskaAddTempPool` 追加记录，标签分别是 `STEADFAST` 与 `PAINFUL_HEALING`，到期时间填绝对时间戳。

## 五、佛法自然的唯一性

复用光子护盾那套机制，三处同时改，缺一处就会两人同持：

| 位置                                  | 改动                                                      |
| ----------------------------------- | ------------------------------------------------------- |
| 目录行第 3 列                            | 写 `1`（唯一性标志）                                            |
| `feskaBuildPool()`                  | 有持有者时过滤掉该卡（与护盾各一条独立 filter）                             |
| `Feska - Replace taken unique card` | 条件与替换循环改成按 `feskaUniqueTechTaken()` 判定，不再出现具体 `Tech_Id` |
| `Feska - Confirm card`              | 同样改成 `feskaUniqueTechTaken()`                           |

**唯一性判定不过滤存活，光环才过滤存活**：死亡不丢科技，如果唯一性也过滤存活，持有者死一次别人就能抢同一张卡。

光环用状态差分维护单个修改器句柄（`Dharma_Mod_Owner` 变化才 stop + start），0.25 秒重算一次中心，僵尸进出 15 米靠每帧重估，没有延迟。特效是纯视觉：每 0.5 秒给 15 米内存活僵尸挂 `ZENYATTA_ORB_OF_DISCORD_TARGET`，出范围或死亡就销毁并置 `Dharma_Orb_Id = 0`。

## 六、实现过程中确认的三个坑

1. **本版本的 `def` 不支持带返回值的 `return`**。`return X` 与 `return null` 都报 `expected the end of the return statement`。原本“用带返回值的子程序取持有者”的方案作废，改成全局量 `Dharma_Holder` 由规则维护。
2. **嵌套 `filter` 共用“当前数组元素”**。`数组.filter(lambda x: ... 另一个数组.filter(lambda y: ...))` 会出 `nested-binder-lambda` 告警，结果不可靠。唯一性过滤因此拆成两条独立 filter，条件里改用布尔宏 `feskaUniqueTechTaken()`。
3. **银质子弹按英雄过滤，只有选牌池一处判断**。判据 `getMaxAmmo(0) > 0`（无弹夹英雄为 0），在 `feskaBuildPool()` 里直接取不到这张卡，规则侧不再重复判断。`Ammo_Before_Hit` 只剩一个职责：同一发命中多只僵尸时只结算一次（霰弹枪打 3 只不会吃 3 次 250%）。

## 七、必须游戏内验证

| 序号 | 待验证                                                          | 失败后果                                                                                       |
| -- | ------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| 1  | 池表重建后三池是否照常: 受击前 `getHealthOfType(Health.SHIELDS/ARMOR)` 有值、击穿后归零、下一阶段重建 | 重做后的 `feskaAddTempPool` 若仍不建池, 护盾/血肉/反甲会集体变空卡, 这是本轮改动的唯一风险集中点。先看是否有池, 再看池是否按标签重建 |
| 2  | 无弹夹英雄（莱因哈特、布丽吉特、温斯顿等）`getMaxAmmo(0)` 的返回值                    | 若返回 >0，选牌池过滤失效，卡会发给用不上弹夹的英雄。判据用 `getMaxAmmo` 而不是 `getAmmo`：前者是弹夹容量，后者在打空时也是 0，区分不开。这条是唯一防线 |
| 3  | `playerDealtKnockback` / `playerReceivedKnockback` 在本模式的实际触发 | 事件不触发则大运来咯等同空卡                                                                             |
| 4  | `startDamageModification` 的接收者数组是否随每帧重估                      | 不重估则佛法自然只在建句柄那一刻对范围内僵尸生效                                                                   |
| 5  | 生命池句柄跨死亡是否失效                                              | 重生时 `feskaClearAllTempPools` 会对旧句柄 `removeHealthPool` 再重建; 若失效句柄报错, 重生流程会中断                                      |
| 6  | 死亡之舞的流血 DOT 是否计入受击统计                                         | 若计入，会绕过 `attacker != null` 触发坚韧、十字军铠甲、反甲                                                                |

## 八、已作废

- 上版候选 N 组其余 26 项、M 组其余 29 项、L 组其余 13 项、P 组 18 项、更早的 K 组 7 项与血怒/以痛为盾/血债/战地急救/锁链/战旗/势沉/震退，全部删除。
- 佛法的“每 0.5 秒选一名持有者当光环中心”方案：改成全局唯一后不需要了。
- 佛法的“派生伤害兜底”方案：乘算已确认，不需要。
