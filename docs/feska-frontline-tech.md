# 费斯卡科技：近战与前排设计稿 v10

状态：**设计稿，未实现**。等确认后落地。编号仅用于讨论，不是代码 ID。落地时从 `Tech_Id 47` 起追加。

## 保留的 10 项

L 组 15 项只留下你要的两项：L04 换成佛法自然（全局唯一），L06 保留死亡之舞但按你的数值重写。其余 13 项全部删除。

| 编号 | 名称 | 效果 |
| --- | --- | --- |
| G01 | 坚定 | 受到伤害时获得 12% 最大生命值的临时护甲，最多 5 层；每层独立持续 5 秒。 |
| G02 | 痛苦疗愈 | 受到的 12% 伤害转换为临时生命值，持续 8 秒。 |
| G03 | 不屈意志 | 每损失 1% 最大生命，获得 1% 伤害减免与 1% 增伤。 |
| N11 | 亡语 | 阵亡后造成爆炸，对 25 米范围内的敌人造成你 50% 最大生命值的额外伤害。 |
| N17 | 坚韧 | 受到伤害后，接下来 4 秒内受到的伤害降低 40%。 |
| N20 | 屹立不倒 | 每损失 1% 最大生命，获得 1% 全能吸血。 |
| N30 | 大运来咯 | 你造成的击退会将敌人击倒 1 秒。 |
| M04 | 银质子弹 | 弹匣的最后一枚子弹额外造成 250% 伤害。 |
| L04 | 佛法自然〔唯一〕 | 15 米内的僵尸视为易损，受到的伤害增加 25%。 |
| L06 | 死亡之舞 | 受到的伤害 50% 在 2 秒内以流血形式扣除；击杀僵尸回复 25~75 + 5% 最大生命值。 |

## 已定方案

1. **减伤上限 = 所有减伤相加后不超过 90%**。`feskaReceivedPercent` 改为 `100 - min(减伤总和, 90)`，加算，不再逐层相乘。
   - 连带改动：一夫当关现在是乘 `0.85`，要改成加算 15% 并入总和。
   - 风险：改口径后现有配装的实战减伤会变。属性减伤 + 一夫当关 + 坚韧 40% 三项就可能顶到 90 上限。
2. **全能吸血不设上限**。N20 按缺失生命百分比全额生效。
3. **共用临时生命池表，并迁移旧池**。玩家级三张平行数组：`Temp_Pool_Ids`、`Temp_Pool_Handles`、`Temp_Pool_Expire_At`。
   - 两种操作：`register`（追加一条，到期移除）、`refresh`（按 id 删旧条再追加，用于周期重建的池）。
   - 迁入：光子护盾、血肉再生、反应装甲。坚定、痛苦疗愈走这张表。
   - 不迁：心之钢与护甲强化是永久池，没有到期时间。
   - 风险：OverPy 数组操作返回副本，删除必须整体赋回，三表索引必须同步；迁移动四份已验证代码，要逐项回归。
4. **亡语保持原样**：25 米、50% 最大生命，每次阵亡触发。玩家复活有条件，死亡是稀缺事件，不限次。
5. **大运来咯只覆盖击退**：只认 `playerReceivedKnockback`，不含钩子拉拽、上勾拳这类非击退位移。

## 一、佛法自然（L04）实现

**机制**：不给每只僵尸单独挂易伤标记，直接改伤害结算倍率。

`startDamageModification(receivers, damagers, damagePercent, reevaluation)` 就是这个用途。第三个参数是百分比，`DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT` 让接收者、施加者、百分比每帧重估。因此接收者写 `getPlayersInRadius(光环中心, 15, Team.1, LosCheck.SURFACES)` 就够了，僵尸走进走出 15 米自动增删，不需要自己扫。

**叠加方式确认为乘算**，与 `src/mode/difficulty.opy` 的难度修改器互不覆盖，最终倍率是「难度系数 × 1.25」。

**改为全局唯一科技**。乘算是两人同拿就是 1.5625，与其在运行时选一个“生效的那份”，不如让它根本不可能被第二个人拿到。项目里已有这套机制，光子护盾就是这么做的，照抄三处：

| 位置 | 光子护盾现状 | 佛法自然照做 |
| --- | --- | --- |
| 目录行第 3 列（唯一性标志） | 写 `1` | 同样写 `1` |
| `feskaBuildPool()` | 有持有者时过滤掉 `Tech_Id.SHIELD` | 加一条同样的过滤 |
| 规则 `Feska - Replace taken unique card` | 硬编码只处理 `Tech_Id.SHIELD` | 改成按“已占用的唯一科技列表”处理，两张卡都覆盖 |

第三处必须一起改，否则会出现这个缺口：别人刚选了佛法自然，你手里的候选卡还留着它，选中后两人同持。

```
#!define feskaDharmaHolders() getPlayers(Team.2).filter(lambda p: not p.isDummy() and Tech_Id.DHARMA in p.Owned_Tech_Ids)
#!define feskaTakenUniqueTechIds() (([Tech_Id.SHIELD] if len(shieldTechHolders()) > 0 else []) + ([Tech_Id.DHARMA] if len(feskaDharmaHolders()) > 0 else []))
```

规则的条件与替换循环都改成基于 `feskaTakenUniqueTechIds()` 判定，不再出现具体 `Tech_Id`。

**唯一之后，光环中心就是唯一的持有者**，不需要定时挑人，也不需要排序。用一个状态差分规则：持有者变了才 stop + start，中心表达式每帧重估，僵尸进出 15 米自动增删。

```
rule "Feska - Dharma aura":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition feskaDharmaHolder() != Dharma_Mod_Owner

    if Dharma_Mod_Id != null:
        stopDamageModification(Dharma_Mod_Id)
        Dharma_Mod_Id = null
    Dharma_Mod_Owner = feskaDharmaHolder()
    if Dharma_Mod_Owner != null:
        startDamageModification(getPlayersInRadius(Dharma_Mod_Owner, 15, Team.1, LosCheck.SURFACES),
                                getPlayers(Team.2), 125,
                                DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
        Dharma_Mod_Id = getLastDamageModification()
```

`feskaDharmaHolder()` 取列表第一个，并带 `isAlive()`：持有者死亡期间光环关闭，复活后条件自然变化、规则重新建句柄。持有者离场则 `feskaDharmaHolders()` 为空，句柄被停掉，同时池子里重新放出这张卡。

两点实现约定：

- **唯一性看 `feskaDharmaHolders()`（不过滤存活），光环看 `feskaDharmaHolder()`（过滤存活）**。死亡不丢失科技，若唯一性也过滤存活，持有者死一次别人就能抢同一张卡，会变成两人同持。
- `feskaDharmaHolder()` 用带返回值的 `def` 写（`if len(...) > 0: return ...` 否则 `return null`），在规则条件里直接调用。这两点都用 `wright check` 验过，`errors=0`。

**为什么不改成加算**：难度减伤走 `zombieDamageReceivedPercent()`，是一个全队共用的宏（`100 - 档位 - 3 × 额外人数`）。把 +25 并进那个宏，只能对全部僵尸生效，做不到“只有 15 米内”。要范围限定就必须用独立修改器，独立修改器之间只有乘算。这就是保留乘算的原因。

**乘算后的实际数值**（苦难难度，难度值 × 1.25）：

| 玩家数 | 难度值 | ×1.25 | 相对 100 基线 |
| --- | --- | --- | --- |
| 1 | 85 | 106 | +6% |
| 2 | 82 | 103 | +3% |
| 3 | 79 | 99 | -1% |
| 4 | 76 | 95 | -5% |

最不利的 1 人苦难也只到 106%，不会出现“15 米内比简单难度还疼”的异常。

**禅雅塔乱的特效**：`Effect` 枚举里有 `ZENYATTA_ORB_OF_DISCORD_TARGET`，`createEffect` 的 position 可以传 Player 并配 `EffectReeval.POSITION_AND_RADIUS`，效果会跟着僵尸走。唯一科技只有一名持有者，所以扫描只由他一个人跑，用时间戳限流而不是 `wait` 循环：

```
rule "Feska - Dharma orb":
    @Event eachPlayer
    @Team 2
    @Condition Is_Attack_Phase
    @Condition eventPlayer == feskaDharmaHolder()
    @Condition getTotalTimeElapsed() >= Dharma_Orb_Next_At

    Dharma_Orb_Next_At = getTotalTimeElapsed() + 0.5
    # 扫 15 米内存活僵尸: 没有 Dharma_Orb_Id 就建, 出范围或死亡就销毁并置空
```

僵尸侧用一个 `playervar Dharma_Orb_Id` 存实体 id，`destroyEffect` 后就置 `null`。僵尸死亡与回收走同一个清理分支，不依赖僵尸对象被移除的时机。

**特效实体的成本**：`createEffect` 有数量上限，超过就不再创建。僵尸上限在 `Zombie_Alive_Limit`，如果 15 米内可能同时挤进 40 只以上，加一条软上限：超过 30 只只保留伤害加成，不再创建特效。特效是纯视觉，关掉不影响数值。

**改动清单**：

| 文件 | 改动 |
| --- | --- |
| `src/env/vars.opy` | `Tech_Id.DHARMA = 47`；`globalvar Dharma_Mod_Id`、`Dharma_Mod_Owner`、`Dharma_Orb_Next_At`；`playervar Dharma_Orb_Id` |
| `src/player/feska/tech/dharma.opy` | 新建：目录行（第 3 列写 1）、`feskaDharmaHolders()`、`feskaDharmaHolder()`、`feskaTakenUniqueTechIds()`、光环规则、特效规则 |
| `src/player/progression.opy` | 追加 `#!include`；目录末尾追加行；`feskaBuildPool()` 加唯一过滤；`Feska - Replace taken unique card` 改为按 `feskaTakenUniqueTechIds()` 判定 |

唯一卡替换规则是已实现并经测试的代码，改完要回归光子护盾的并发唯一性：两人同时看到这张卡、一人先选、另一人的在场候选必须被换掉。

## 二、死亡之舞（L06）实现

**结算顺序**：伤害已经发生，工坊无法“延后支付”，只能**先回补再扣回**。

1. `playerTookDamage`，条件是 `attacker != null` 且 `attacker.getTeam() == Team.1`。
2. 立即回补：`heal(eventPlayer, eventPlayer, 回补量)`。
3. 起一段 2 秒流血：`startDamageOverTime(null, 2, 回补量 / 2)`。

`startDamageOverTime` 的第三个参数是**每秒伤害**，不是总量（现有 `ignite.opy` 的 5% × 3 秒就是这么写的）。

**回补量必须夹上限**，这是本项唯一的正确性要求：

```
min(eventDamage * 0.5, eventPlayer.getMaxHealth() - eventPlayer.getHealth())
```

满血时回补会被最大生命截断，但流血的 DOT 不会。如果直接按 50% 起 DOT，满血挨一下就是“回补 0、多扣 50%”，玩家凭空多受伤。夹住之后满血状态等于本项不生效，不亏不赚。

**流血不触发自身**：DOT 的 damager 传 `null`，`attacker` 为空，上面那条 `attacker != null` 的条件把它排除，不会循环。同一条条件也把流血挡在其他“受到伤害时”类科技之外，见第四节。

**击杀回复**：`playerDealtFinalBlow` 时 `heal(eventPlayer, eventPlayer, 25~75 + 最大生命 * 0.05)`。25~75 我按进攻波次线性插值，写 `25 + 50 * min(Current_Wave / Total_Wave_Count, 1)`；如果你指的是别的口径（比如按缺失生命），告诉我改。

**兜底风险**：回补走的是治疗通道，会被治疗削减（禁疗、狂战士之魂）影响；狂战士期间禁疗则回补为 0，此时必须同步把 DOT 也置 0，否则就是纯多扣。这条要写进实现。

## 三、10 项的实现与风险

| 编号 | 名称 | 实现与风险 |
| --- | --- | --- |
| G01 | 坚定 | A 级：共用池表，每层一条（id + handle + 到期）。不能整池重建，否则已吸收的护甲会被补回。满层是 60% 最大生命的额外护甲。 |
| G02 | 痛苦疗愈 | A 级：同一张池表，一条记录，8 秒到期移除。与十字军铠甲的固定回补同时生效，文案要区分。 |
| G03 | 不屈意志 | A 级：低频重算，写进伤害与受伤两个百分比宏。减伤按加算并入总和，由 90% 上限兜住。 |
| N11 | 亡语 | B 级：`playerDied` 同帧先快照坐标，再对 `getPlayersInRadius(坐标, 25, Team.1, LosCheck.SURFACES)` 结算。该函数会带上死亡玩家，要按存活过滤。伤害来源用 `null`，不计击杀、不触发吸血链。 |
| N17 | 坚韧 | A 级：单一时间戳窗口，4 秒内每次受击只刷新时长不叠加。按加算并入减伤总和。 |
| N20 | 屹立不倒 | B 级：在 `playerDealtDamage` 里按伤害量回血，必须**聚合结算**（0.25 秒合并一次），否则僵尸密集时每帧 heal 会打穿执行预算；派生伤害打标记防递归；狂战士禁疗期间停用。按你的决定不封顶。 |
| N30 | 大运来咯 | A 级：`playerDealtKnockback` 记录本帧持有者，`playerReceivedKnockback` 在僵尸侧按“本帧 + 12 米”配对，命中后 `setStatusEffect(null, Status.KNOCKED_DOWN, 1)`。AI 已把 `KNOCKED_DOWN` 当行动中止（`src/ai/core.opy:113`）。 |
| M04 | 银质子弹 | B 级：读开火后的 `getAmmo(0)`，命中后弹药归零即视作最后一发。**需游戏内核对事件与弹药扣减的先后**，若事件早于扣减，改为“命中前弹药为 1”。派生伤害标记防递归。堡垒哨兵与巴蒂斯特榴弹有两个弹夹，需定判哪一夹。 |
| L04 | 佛法自然 | A 级：全局唯一，照光子护盾的三处机制实现（目录唯一标志、池子过滤、唯一卡替换规则改为通用判定）。光环用状态差分规则维护单个修改器句柄，与难度修改器乘算。特效 0.5 秒限流扫描，超过 30 只降级为无特效。 |
| L06 | 死亡之舞 | B 级：先回补再起 2 秒 DOT，回补量必须夹当前可恢复生命。挡不住一击致命（伤害先落地）。狂战士禁疗期间回补与 DOT 一起置 0。 |

## 四、受击口径：`attacker != null`（已定）

死亡之舞的流血是 `null` 来源的伤害，会被其他“受到伤害时”类科技当作一次正常受击：

| 冲突 | 后果 | 处理 |
| --- | --- | --- |
| 死亡之舞 × 痛苦疗愈 | 流血的 12% 又转成临时生命，自己吃掉自己的代价 | 触发条件加 `attacker != null` |
| 死亡之舞 × 坚定 | 流血每跳一层护甲，5 层很快堆满 | 同上 |
| 死亡之舞 × 坚韧 | 流血刷新 40% 减伤窗口，等于流血帮玩家续减伤 | 同上，这条影响最大 |
| 死亡之舞 × 佛法自然 | 易损让僵尸打得更疼，死亡之舞延后 50%，两者乘起来接近“免伤 45%” | 数值可接受，放进同一份回归清单一起看 |

规则：**“受到伤害”类科技只在僵尸本体造成伤害时触发**，条件统一加 `attacker != null`。落到现有代码上是三处：

| 文件 | 现状 | 改动 |
| --- | --- | --- |
| `tech/crusader.opy` | `attacker != eventPlayer`，null 能通过，所以流血会给十字军回补，正好抵消死亡之舞 | 加 `attacker != null`，保留原条件继续排除狂战士自损 |
| `tech/thorns.opy` | `attacker.getTeam() == Team.1`，null 时靠条件失败挡住 | 补一条 `attacker != null`，把意图写明，不依赖 null 上的成员调用 |
| `tech/reactive.opy` | 已有 `attacker != null` | 不改 |

新增的 G01 坚定、G02 痛苦疗愈、N17 坚韧直接写这条条件。

## 五、已作废

- **L 组其余 13 项删除**：L01 石像鬼石板甲、L02 铁板靴、L03 振奋盔甲、L05 斯特拉克、L07 巨型九头蛇、L08 破败王者之刃、L09 黑色切割者、L10 三相之力、L11 不灭之握、L12 余震、L13 骸骨镀层、L14 盾击、L15 生命源泉。
- N 组其余 26 项删除，只留 N11、N17、N20、N30。
- M01–M03、M05–M30 作废，只留 M04。
- P01–P18 全部作废。
- 更早删掉的：血怒、以痛为盾、血债、战地急救、锁链、战旗、势沉、震退、K 组 7 项。

## 六、建议的首批

| 顺序 | 编号 | 理由 |
| --- | --- | --- |
| 1 | G01 坚定 | 共用池表的第一条记录，先验证池表设计。 |
| 2 | G02 痛苦疗愈 | 同一张表的第二个使用者。 |
| 3 | G03 不屈意志 | 改两个宏加 90% 加算夹。 |
| 4 | N17 坚韧 | 单时间戳窗口，前排核心体感。 |
| 5 | N30 大运来咯 | 复用原生击退事件，零新增扫描。 |
| 6 | M04 银质子弹 | 只需一处弹药判定。 |
| 7 | L04 佛法自然 | 叠加方式已确认。唯一性机制已存在，但要改一条已实现的规则，放在最后单独回归。 |

死亡之舞排第二批：它要动 `crusader.opy`、`thorns.opy` 两处已验证代码的受击口径，和 G01/G02/N17 的触发条件一起改才成立，不适合和首批混在一起。

## 七、需要你决定

1. **死亡之舞的 25~75**：按波次线性插值对不对，还是按缺失生命或固定 50 点。
2. **银质子弹的弹夹**：堡垒哨兵、巴蒂斯特榴弹有两个弹夹，判 `getAmmo(0)` 还是 `getAmmo(1)`。
