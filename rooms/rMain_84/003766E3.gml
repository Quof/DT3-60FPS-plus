sprite_index=sNormalDoor
bShowArrow=true
exitType=0
newMapX=104
newMapY=1024
if global.gameProgress>=4930 {toRoom=rHiddenVillage_Destroyed}
else {toRoom=rHiddenVillage}
colorChange=1

if global.gameProgress<=4560 {instance_destroy()}
