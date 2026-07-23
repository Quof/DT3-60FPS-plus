locationCheck(10)
global.rbSwitchBlueOn=false
global.zEncZone=1
global.bCanSave=1

if global.gameProgress=610 {global.gameProgress=620}

if global.hasAbilToken[1]=1 and global.gameProgress<=900
{
  global.canCharSwap=1
  charSwitcher(0)
  global.activeAbility[0]=1

  if global.gameProgress<=699
    global.hasAbilToken[1]=2
  else if global.gameProgress>=700 and global.gameProgress<=729
    global.hasAbilToken[1]=3
  else if global.gameProgress>=730
    global.hasAbilToken[1]=4
}

gameProgCheck=string_char_at(global.gameGate2Prog,2)
if gameProgCheck="2" //Reset Dylan Puzzle
{
  var tNewString;
  tNewString=string_delete(global.gameGate2Prog,2,1)
  tNewString=string_insert("1",tNewString,2)
  global.gameGate2Prog=tNewString
  gameProgCheck="1"
}

gameScene=instance_create(0,0,oEvCh4MainA)
for(i=0;i<3;i+=1)
{
  global.mySegmentCheck[i]=0
}

if global.gameProgress>=630 and global.gameProgress<=890
{
  var tempMplay;
  tempMplay=findMusic(203)
  playMusic(tempMplay,0,0)
}
else if global.gameProgress>=910
{
  var tHeartContainer;
  tHeartContainer=instance_create(280,280,oHeartContainer)
  tHeartContainer.objectNum=2
  var tempMplay;
  tempMplay=findMusic(207)
  playMusic(tempMplay,0,0)
}

musicUnload(0)
