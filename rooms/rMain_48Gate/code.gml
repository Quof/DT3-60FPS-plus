locationCheck(48)
global.mapTeleport=0

oPlayer1.initialJumpAcc=-7.1
oPlayer1.jumpTimeTotal=21

abilSetRemove(0)
if global.hasAbilToken[4]>=1 and global.gameProgress<=3060
{
  global.activeAbility[1]=1
  global.hasAbilToken[4]=1
}

if global.gameProgress>=3070
{
  var instrProg;
  instrProg=string_char_at(global.eGateProg,6)
  if instrProg!="7" and instrProg!="9"
  {
    var tNewString;
    tNewString=string_delete(global.eGateProg,6,1)
    tNewString=string_insert("0",tNewString,6)
    global.eGateProg=tNewString
  }
}

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backBarrensA
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.92
backFollow.depth=1499999
backFollow.image_xscale=2.8
backFollow.image_yscale=2.8

gameScene=instance_create(0,0,oEvCh12MainA)
heatTrack=instance_create(0,0,oDesertHeat)

if global.gameProgress=3070 {gameSceneB=instance_create(0,0,oEvCh13MainA)}

var tempMplay;
tempMplay=findMusic(13)
playMusic(tempMplay,0,0)

musicUnload(5)
