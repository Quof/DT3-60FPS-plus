locationCheck(8)
global.mapTeleport=0

global.rbSwitchBlueOn=false
global.wpWaterLevel=368
if global.gameProgress=580 {global.gameProgress=590}

abilSetRemove(0)
if global.hasAbilToken[1]>=1 and global.gameProgress<=900
{
  global.activeAbility[0]=0
  global.hasAbilToken[1]=1
}

if global.gameProgress>=910
{
  var instrProg;
  instrProg=string_char_at(global.eGateProg,2)
  if instrProg!="7" and instrProg!="9"
  {
    var tNewString;
    tNewString=string_delete(global.eGateProg,2,1)
    tNewString=string_insert("0",tNewString,2)
    global.eGateProg=tNewString
  }
}

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backMeadeland1
backFollow.xMoveScale=0.6
backFollow.yMoveScale=1
backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh3MainA)

var tempMplay;
tempMplay=findMusic(1)
playMusic(tempMplay,0,0)

musicUnload(2)
