if global.bTowerDefense=1 {tdStat_Resources=400+600; maxWave=10-5}      //spsp for all of these
else if global.bTowerDefense=2 {tdStat_Resources=600+400; maxWave=10}
else if global.bTowerDefense=3 {tdStat_Resources=1000-1000; maxWave=10-7}
else if global.bTowerDefense=4 {tdStat_Resources=2500-2500; maxWave=10-9}
else if global.bTowerDefense=5 {tdStat_Resources=3000-3000; maxWave=10}
else {tdStat_Resources=500; maxWave=10}

tdStat_Turrets=0
tdStat_Wave=0
tdStat_Stability=10

turretCapacityCost=400
stabilityCapacityCost=400
recoverCost=100
repairCooldown=0

maxTurrets=20
maxStability=10

bCanConstruct=1
bCanUpgrade=0
bCanDeconstruct=0
bCanBaseUpgrade=0

statDisplayTime=0
turretID=-1

tiStat_Type=""
tiStat_Lv=1
tiStat_Power=1
tiStat_FireRate=1
