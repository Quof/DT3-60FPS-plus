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
  //(the beaten bosses by type, when the save's boss list isn't this build's; a save from before the list was kept has
  //the one the builds before it had: rndgen's BOSS_TYPES_OLD)
  var tTypes;
  tTypes=ini_read_string(s,"bosstypes",global.rndBossTypesOld)
  if tTypes!=global.rndBossTypes {global.rndBossDone=rndBossFromTypes(global.rndBossDone,tTypes)}
  rndOwnFromString(ini_read_string(s,"own",""))
  global.rndKeyOwn=ini_read_string(s,"keys","")
  global.rndEShopStr=ini_read_string(s,"eshop","")
  global.rndWon=ini_read_real(s,"won",0)
  //the enemy traps beaten, by name. A save from before them has none of them: its seed's items were placed without
  //them, so they stay away (all counted beaten)
  var tTraps,k;
  if ini_key_exists(s,"traps")
  {
    tTraps=","+ini_read_string(s,"traps","")
    global.rndTrapDone=string_repeat("0",global.rndTrapN)
    for(k=0;k<global.rndTrapN;k+=1) {if string_pos(","+global.rndTrapName[k]+",",tTraps)>0 {global.rndTrapDone=rndSetChar(global.rndTrapDone,k+1,"1")}}
  }
  else {global.rndTrapDone=string_repeat("1",global.rndTrapN)}
  //Entrance Rando: the shuffle back (the door data read again: rndERLoad), if this build's doors are the ones it was
  //made with
  global.rndERMode=ini_read_real(s,"er",0)
  if global.rndERMode>0
  {
    var t,n,i,h;
    h=ini_read_string(s,"erhash","")
    n=ini_read_real(s,"erparts",0)
    t=""
    for(i=0;i<n;i+=1) {t+=ini_read_string(s,"erpart"+string(i),"")}
    if rndERLoad()=0
    {
      global.rndERMode=0
      show_message("Randomizer: this game's entrances are shuffled (Entrance Rando), but the mod's door data (data\rndER.txt) isn't there or doesn't fit this build. The entrances lead where they normally do.")
    }
    else if h!=global.rndEHash or rndERFromString(t)=0
    {
      global.rndERMode=0
      show_message("Randomizer: this game's entrances were shuffled (Entrance Rando) with another build's doors, so the shuffle can't be put back. The entrances lead where they normally do.")
    }
    else {rndERMapBuild()}
  }
  //Boss Rando: the shuffle back, if this build's bosses are the ones it was made with
  global.rndBRMode=ini_read_real(s,"br",0)
  if global.rndBRMode=1
  {
    if ini_read_string(s,"brtypes","")!=rndBRString(1) or rndBRFromString(ini_read_string(s,"brfight",""))=0
    {
      global.rndBRMode=0
      show_message("Randomizer: this game's bosses were shuffled (Boss Rando) with another build's bosses, so the shuffle can't be put back. Each boss is fought in its own place.")
    }
  }
  //Instrument Randomization: on or off
  global.rndIRMode=ini_read_real(s,"ir",0)
  //a save from a build with other data: what's missing reads as not got yet (then brought up to this build: rndLoadOld)
  if string_length(global.rndGot)<global.rndLocN {global.rndGot+=string_repeat("0",global.rndLocN-string_length(global.rndGot))}
  if string_length(global.rndBossDone)<global.rndBossN {global.rndBossDone+=string_repeat("0",global.rndBossN-string_length(global.rndBossDone))}
  rndLoadOld()
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
