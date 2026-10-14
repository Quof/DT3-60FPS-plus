event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0
spawnX=room_width+32
spawnY1=83
spawnY2=121
spawnY3=159
spawnY4=198
spawnY5=236
spawnY6=275
spawnY7=313

//spsp ns
shroudDelay=60

asteroidX=room_width+64
asteroidY1=108
asteroidY2=198
asteroidY3=288

otherTimeA=0
changeBackground=0
astProg=0

global.levelTimeSecond=10

sceneProgress=global.newMapX
if sceneProgress>=11 {global.shooterDifficulty=2}
if sceneProgress<=3
{
  backFollow=instance_create(0,0,oBackgroundFollow)
  backFollow.type=1
  backFollow.backSet=backShooterA; backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
  backFollow.image_xscale=1.38; backFollow.image_yscale=1.38
  backFollow.depth=1499999; backFollow.xScrollSpeed=-1
}
else if sceneProgress>=4 and sceneProgress<=7
{
  backFollow=instance_create(0,0,oBackgroundFollow)
  backFollow.type=1
  backFollow.backSet=backShooterB; backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
  backFollow.image_xscale=1.38; backFollow.image_yscale=1.38
  backFollow.depth=1499999; backFollow.xScrollSpeed=-1
}
else if sceneProgress>=8 and sceneProgress<=11
{
  backFollow=instance_create(0,0,oBackgroundFollow)
  backFollow.type=1
  backFollow.backSet=backShooterC; backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
  backFollow.image_xscale=1.58; backFollow.image_yscale=1.58
  backFollow.depth=1499999; backFollow.xScrollSpeed=-1
}
else if sceneProgress>=12
{
  backFollow=instance_create(0,0,oBackgroundFollow)
  backFollow.type=1
  backFollow.backSet=backShooterD; backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
  backFollow.depth=1499999; backFollow.xScrollSpeed=-1
}
