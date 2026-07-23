locationCheck(56)
global.partySplit=0
global.mapTeleport=0
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backBurningStretchA
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.92
backFollow.depth=1499999

if global.gameProgress>=3870
{
  var instrProg;
  instrProg=string_char_at(global.eGateProg,7)
  if instrProg!="7" and instrProg!="9"
  {
    var tNewString;
    tNewString=string_delete(global.eGateProg,7,1)
    tNewString=string_insert("0",tNewString,7)
    global.eGateProg=tNewString
  }
}

gameScene=instance_create(0,0,oEvCh14MainA)

abilSetRemove(0)

if global.gameProgress<=3860
{
  if global.canDoubleJump=2 {global.canDoubleJump=1}
}

var tempMplay;
tempMplay=findMusic(14)
playMusic(tempMplay,0,0)

musicUnload(6)
