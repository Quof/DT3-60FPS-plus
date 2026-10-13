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
  //Archipelago: its seed line, the items it has given and deaths it has sent, and the client's session; told when the
  //client isn't connected to this game's multiworld (its checks and items wait till it is)
  global.rndAP=ini_read_real(s,"ap",0)
  if global.rndAP=1
  {
    global.rndApSeedLine=ini_read_string(s,"apseed","")
    global.rndApRecv=ini_read_real(s,"aprecv",0)
    global.rndApDeaths=ini_read_real(s,"apdeaths",0)
    if rndApReadSession()=0 or global.rndApSession!=global.rndApSeedLine
    {
      show_message("Archipelago: the DT3+ Client isn't connected to this game's multiworld ("+string_replace_all(string_delete(global.rndApSeedLine,1,5),"|",", slot ")+"). Its checks are kept and sent, and its items come, once it is.")
    }
    rndApStart()
  }
}
