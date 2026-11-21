# 费斯卡科技：近战与前排（v11，已落地）

状态：**已在代码中实现**，`pnpm run compile` 结果为 `errors=0`。编号 43–52，与 `Tech_Id` 和 `Upgrade_Catalog` 的末尾 10 行一一对齐。编译通过不等于游戏内验证，第六节列了必须实测的项。

## 一、10 项科技

| 编号 | 名称 | 文件 | 效果 |
| --- | --- | --- | --- |
| 43 | 坚定 | `tech/steadfast.opy` | 受到伤害时获得 12% 最大生命值的临时护甲，最多 5 层，每层独立 5 秒 |
| 44 | 痛苦疗愈 | `tech/painful_healing.opy` | 受到伤害的 12% 转换为临时生命值，8 秒后移除 |
| 45 | 不屈意志 | `tech/indomitable.opy` | 每损失 1% 最大生命，获得 1% 减伤与 1% 增伤 |
| 46 | 坚韧 | `tech/resolute.opy` | 受到伤害后 4 秒内受到的伤害降低 40% |
| 47 | 大运来咯 | `tech/knockdown.opy` | 你造成的击退会将敌人击倒 1 秒 |
| 48 | 银质子弹 | `tech/silver_bullet.opy` | 弹匣最后一枚子弹额外造成 250% 伤害 |
| 49 | 佛法自然〔唯一〕 | `tech/dharma.opy` | 15 米内的僵尸受到的伤害增加 25% |
| 50 | 亡语 | `tech/death_rattle.opy` | 阵亡后爆炸，25 米内敌人受到你 50% 最大生命值的伤害 |
| 51 | 屹立不倒 | `tech/unyielding.opy` | 每损失 1% 最大生命，获得 1% 全能吸血，不封顶 |
| 52 | 死亡之舞 | `tech/death_dance.opy` | 受到伤害的 50% 在 2 秒内以流血扣除；击杀回复 25～75 + 5% 最大生命值 |

两条本轮新定的口径：死亡之舞的 25～75 **按进攻波次线性插值**（`feskaGrowthAt(progress, 25, 50)`）；银质子弹**判第 0 个弹夹**（`getAmmo(0) == 0`），并且**只发给带弹夹的英雄**——选牌池里按 `getMaxAmmo(0) > 0` 过滤，见第六节。

## 二、地基一：受击口径 `attacker != null`

脚本流血与自损的 `attacker` 为 `null`，会被“受到伤害时”类科技当成一次正常受击。所有受击触发统一要求 `attacker != null`：

| 文件 | 改动 |
| --- | --- |
| `tech/crusader.opy` | 新增 `attacker != null`，保留 `attacker != eventPlayer` 继续排除狂战士自损 |
| `tech/thorns.opy` | 新增 `attacker != null`，不再依赖在 `null` 上调用 `getTeam()` |
| `tech/reactive.opy` | 原本已有，不改 |
| 新增的坚定、痛苦疗愈、坚韧、死亡之舞 | 直接写这条条件 |

## 三、地基二：减伤加算，总和封顶 90%

```
#!define feskaReceivedPercent(p) (100 - min(p.Bonus_By_Stat[Stat_Bonus.DAMAGE_REDUCTION] + (15 if p.Is_Alone else 0) + (40 if p.Is_Resolute else 0) + p.Missing_Health_Percent, 90))
```

- 一夫当关的 `×0.85` 改成加算 15 并入总和。
- 属性强化·减伤原来单项夹在 50%，现在只累加，由总和上限兜住。
- 不屈意志与坚韧都进这个总和，因此“残血 + 坚韧 + 一夫当关”不会各自夹取上限后绕过封顶。

不屈意志的增伤走另一条宏：`feskaDamagePercent` 加上 `Missing_Health_Percent`，不封顶。

缺失生命的口径是 `100 - 100 × getHealth() / feskaMaxHealth`，生命池挡下的伤害不算失血，因此不会“被护盾打反而增伤”。

## 四、地基三：共用临时生命池表

三张玩家级平行数组，下标一一对应：

| 字段 | 内容 |
| --- | --- |
| `Temp_Pool_Ids` | 来源标签（`Temp_Pool_Id`：SHIELD / FLESH_REGENERATION / REACTIVE / STEADFAST / PAINFUL_HEALING） |
| `Temp_Pool_Handles` | `addHealthPool` 返回的池句柄 |
| `Temp_Pool_Expire_At` | 绝对到期时间，`0` 表示不按时间到期 |

四个操作都在 `pools.opy`，入参走全局量（`Target_Player` + `Temp_Pool_Tag/Type/Amount/Expire`）：

| 子程序 | 用途 |
| --- | --- |
| `feskaAddTempPool` | 追加一条记录（register） |
| `feskaClearTempPoolsByTag` | 按标签删旧记录（refresh 的前半步） |
| `feskaClearAllTempPools` | 重生/换英雄时全清 |
| 规则 `Feska - Temp pool expiry` | 每 0.25 秒扫一次，移除到期的记录 |

迁入的三个旧池：光子护盾（SHIELDS）、血肉再生（NORMAL）、反应装甲（ARMOR），都是 `refresh` 语义（整池重建，`Expire = 0`）。心之钢与护甲强化是永久池，不迁。坚定、痛苦疗愈是 `register` 语义（各自到期）。

三个实现约束：

1. **三张表必须同时重组后整体赋回**。OverPy 的数组操作返回副本，只删一张表会让三张表错位，之后会移除错误的池。
2. **未初始化玩家的数组字段还是默认值 `0`**，`len(0)` 会中断整条规则。所有遍历都先判 `Is_Initialized`。
3. 到期规则对“已被伤害打空、由引擎自动移除的池”仍会再调一次 `removeHealthPool`。这是本批唯一无法靠编译确认的点，见第六节第 1 条。

## 五、佛法自然的唯一性

复用光子护盾那套机制，三处同时改，缺一处就会两人同持：

| 位置 | 改动 |
| --- | --- |
| 目录行第 3 列 | 写 `1`（唯一性标志） |
| `feskaBuildPool()` | 有持有者时过滤掉该卡（与护盾各一条独立 filter） |
| `Feska - Replace taken unique card` | 条件与替换循环改成按 `feskaUniqueTechTaken()` 判定，不再出现具体 `Tech_Id` |
| `Feska - Confirm card` | 同样改成 `feskaUniqueTechTaken()` |

**唯一性判定不过滤存活，光环才过滤存活**：死亡不丢科技，如果唯一性也过滤存活，持有者死一次别人就能抢同一张卡。

光环用状态差分维护单个修改器句柄（`Dharma_Mod_Owner` 变化才 stop + start），0.25 秒重算一次中心，僵尸进出 15 米靠每帧重估，没有延迟。特效是纯视觉：每 0.5 秒给 15 米内存活僵尸挂 `ZENYATTA_ORB_OF_DISCORD_TARGET`，出范围或死亡就销毁并置 `Dharma_Orb_Id = 0`。

## 六、实现过程中确认的三个坑

1. **本版本的 `def` 不支持带返回值的 `return`**。`return X` 与 `return null` 都报 `expected the end of the return statement`。原本“用带返回值的子程序取持有者”的方案作废，改成全局量 `Dharma_Holder` 由规则维护。
2. **嵌套 `filter` 共用“当前数组元素”**。`数组.filter(lambda x: ... 另一个数组.filter(lambda y: ...))` 会出 `nested-binder-lambda` 告警，结果不可靠。唯一性过滤因此拆成两条独立 filter，条件里改用布尔宏 `feskaUniqueTechTaken()`。
3. **银质子弹按英雄过滤，不靠“上一发还有子弹”兜底**。判据用 `getMaxAmmo(0) > 0`（无弹夹英雄为 0），选牌时就排除，规则条件里再判一次，兜住“先拿卡、后换到无弹夹英雄”的情况。`Ammo_Before_Hit` 只剩一个职责：区分“打空最后一发”和“弹夹本来就是 0”，以及同一发命中多只僵尸只结算一次。宏 `feskaHeroHasAmmo` 放在 `vars.opy`，因为 `feskaBuildPool` 在 `progression.opy` 第 55 行就用到它，而科技 include 在第 440 行。

## 七、必须游戏内验证

| 序号 | 待验证 | 失败后果 |
| --- | --- | --- |
| 1 | 对已被打空的池调用 `removeHealthPool` 是否安全 | 若报错，到期规则会中断，三张表不同步，之后会移除错误的池 |
| 2 | 无弹夹英雄（莱因哈特、布丽吉特、温斯顿等）`getMaxAmmo(0)` 的返回值 | 若返回 >0，选牌池过滤失效，卡会发给用不上弹夹的英雄。判据已从 `getAmmo` 换成 `getMaxAmmo`，两种英雄的正常值应是 0 与非 0 |
| 3 | `playerDealtKnockback` / `playerReceivedKnockback` 在本模式的实际触发 | 事件不触发则大运来咯等同空卡 |
| 4 | `startDamageModification` 的接收者数组是否随每帧重估 | 不重估则佛法自然只在建句柄那一刻对范围内僵尸生效 |
| 5 | 生命池记录跨死亡是否被引擎清掉 | 若清了，`feskaClearAllTempPools` 会对失效句柄调 `removeHealthPool` |
| 6 | 死亡之舞的流血 DOT 是否计入受击统计 | 若计入，会绕过 `attacker != null` 触发坚定/痛苦疗愈/坚韧 |

## 八、已作废

- 上版候选 N 组其余 26 项、M 组其余 29 项、L 组其余 13 项、P 组 18 项、更早的 K 组 7 项与血怒/以痛为盾/血债/战地急救/锁链/战旗/势沉/震退，全部删除。
- 佛法的“每 0.5 秒选一名持有者当光环中心”方案：改成全局唯一后不需要了。
- 佛法的“派生伤害兜底”方案：乘算已确认，不需要。
