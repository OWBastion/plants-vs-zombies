#!mainFile "../../main.opy"

# 远距离衰减补偿已移除, 恢复原生衰减; 英雄武器平衡不再由模式脚本改写。


rule "[Cassdy] Peacekeeper Alt Fire":
    @Event eachPlayer
    @Team 2
    @Hero cassidy
    @Condition eventPlayer.isFiringSecondaryFire() == true

    eventPlayer.setDamageDealt(180)
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 0.75)
    eventPlayer.setDamageDealt(100)
