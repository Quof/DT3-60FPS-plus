locationCheck(28)
global.mapTeleport=0
global.tempAction[0]=0

abilSetRemove(0)
if global.hasAbilToken[3]>=1 and global.gameProgress<=1980
{
  global.activeAbility[0]=1
  global.hasAbilToken[3]=1
  if global.gameProgress>=1920 {global.charScan[0]=1}
}

if global.gameProgress>=1990
{
  var instrProg;
  instrProg=string_char_at(global.eGateProg,4)
  if instrProg!="7" and instrProg!="9"
  {
    var tNewString;
    tNewString=string_delete(global.eGateProg,4,1)
    tNewString=string_insert("0",tNewString,4)
    global.eGateProg=tNewString
  }
}

gameScene=instance_create(0,0,oEvCh7MainA)

for(i=0;i<2;i+=1)
{
  backGStatic=instance_create(255+(i*256),117,oBackgroundStatic)
  backGStatic.backSet=backBegoniaF
  backGStatic.image_angle=180
}

var tempMplay;
tempMplay=findMusic(7)
playMusic(tempMplay,0,0)

musicUnload(4)
