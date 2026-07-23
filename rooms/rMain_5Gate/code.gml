locationCheck(5)
global.mapTeleport=0

if global.gameProgress=110 {global.gameProgress=120}

abilSetRemove(0)
if global.hasAbilToken[0]>=1 and global.gameProgress<=500 {global.hasAbilToken[0]=1}

if global.gameProgress>=510
{
  var instrProg;
  instrProg=string_char_at(global.eGateProg,1)
  if instrProg!="7" and instrProg!="9"
  {
    var tNewString;
    tNewString=string_delete(global.eGateProg,1,1)
    tNewString=string_insert("0",tNewString,1)
    global.eGateProg=tNewString
  }
}

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backMeadeland1
backFollow.xMoveScale=0.6
backFollow.yMoveScale=1
backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh1MainA)
sideChat=instance_create(0,0,oEvCh1SideA)

var tempMplay;
tempMplay=findMusic(1)
playMusic(tempMplay,0,0)

musicUnload(1)
