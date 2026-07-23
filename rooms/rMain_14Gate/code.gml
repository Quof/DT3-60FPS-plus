locationCheck(14)
global.mapTeleport=0

abilSetRemove(0)
if global.hasAbilToken[2]>=1 and global.gameProgress<=1510
{
  global.activeAbility[1]=0
  global.hasAbilToken[2]=1
}

if global.gameProgress>=1520
{
  var instrProg;
  instrProg=string_char_at(global.eGateProg,3)
  if instrProg!="7" and instrProg!="9"
  {
    var tNewString;
    tNewString=string_delete(global.eGateProg,3,1)
    tNewString=string_insert("0",tNewString,3)
    global.eGateProg=tNewString
  }
}

gameScene=instance_create(0,0,oEvCh5MainA)

var tempMplay;
tempMplay=findMusic(4)
playMusic(tempMplay,0,0)

musicUnload(3)
