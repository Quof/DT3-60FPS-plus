//Randomizer: its part of the save file (the save file is open). A save made without it leaves it off
var s;
s="Randomizer"
global.rndActive=ini_read_real(s,"active",0)
if global.rndActive=1
{
  global.rndSeed=ini_read_real(s,"seed",0)
  global.rndPlace=ini_read_string(s,"place","")
  global.rndGot=ini_read_string(s,"got","")
  global.rndBossDone=ini_read_string(s,"boss","")
  rndOwnFromString(ini_read_string(s,"own",""))
  global.rndKeyOwn=ini_read_string(s,"keys","")
  global.rndEShopStr=ini_read_string(s,"eshop","")
  global.rndWon=ini_read_real(s,"won",0)
  //a save from a build with other data: what's missing reads as not got yet
  if string_length(global.rndGot)<global.rndLocN {global.rndGot+=string_repeat("0",global.rndLocN-string_length(global.rndGot))}
  if string_length(global.rndBossDone)<global.rndBossN {global.rndBossDone+=string_repeat("0",global.rndBossN-string_length(global.rndBossDone))}
  if string_length(global.rndKeyOwn)<50 {global.rndKeyOwn+=string_repeat("0",50-string_length(global.rndKeyOwn))}
  rndShopFromString()
  global.gameProgress=global.rndWorldProg
  rndAbilApply()
}
