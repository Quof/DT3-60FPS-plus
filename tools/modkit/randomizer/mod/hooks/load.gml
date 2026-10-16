//Randomizer: its part of the save file (the save file is open). A save made without it leaves it off
var s;
s="Randomizer"
//(a loaded game isn't in a randomizer boss fight, even one left going in this session: a fight whose room was walked
//out of by an earlier build, which no boss's fight could start after till the game was started again)
global.rndFight=-1
global.rndFightSlot=-1
global.rndFightLink=0
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
  //(the places whose fight has been seen, read the same way; a save from before them: the ones beaten)
  global.rndBossSeen=ini_read_string(s,"bossseen",ini_read_string(s,"boss",""))
  if tTypes!=global.rndBossTypes {global.rndBossSeen=rndBossFromTypes(global.rndBossSeen,tTypes)}
  if string_length(global.rndBossSeen)<global.rndBossN {global.rndBossSeen+=string_repeat("0",global.rndBossN-string_length(global.rndBossSeen))}
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
  //made with, or an earlier build's this one still has (rndERAccept: then as it was made)
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
    else if rndERAccept(h,t)=0
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
  //Chip Randomizer: on or off (the chips among the items or not: rndChipApply), and the Program Chips found; a save from
  //before it, or with it off, has all six. Where the player is now counts as let in (rndLastGate: the roomStart hook)
  rndChipApply(ini_read_real(s,"chips",0))
  global.rndChipOwn=string_repeat("1",global.rndChipN)
  if global.rndChipMode=1 {global.rndChipOwn=ini_read_string(s,"chipown",global.rndChipOwn)}
  if string_length(global.rndChipOwn)<global.rndChipN {global.rndChipOwn+=string_repeat("0",global.rndChipN-string_length(global.rndChipOwn))}
  global.rndLastGate=-1
  //Traps: on or off (the trap items in the items: rndSnareApply; a save from before them has them off), each trap's
  //time left, a Teleport Trap waiting, and the ways into rooms kept for one
  var tk,tH,tN;
  rndSnareApply(ini_read_real(s,"traps",0))
  for(tk=1;tk<=4;tk+=1) {global.rndSnareT[tk]=ini_read_real(s,"trapt"+string(tk),0)}
  global.rndSnarePend=ini_read_real(s,"trappend",0)
  tN=ini_read_real(s,"traphparts",0)
  tH=""
  for(tk=0;tk<tN;tk+=1) {tH+=ini_read_string(s,"traph"+string(tk),"")}
  rndSnareHistFromString(tH)
  //Gate 5 (location 49): a save made there holds its checkpoint, not the room the player was in (the game's saveData).
  //One made before the roomStart hook set the checkpoint where the player came into the gate from outside it can hold a
  //new game's: room 0, the game's intro, which goes to the title screen. That save loads in the room the player was in
  //(130rm, which the game saves there too) at its first way in (the entrance tables'), else where the run starts. The
  //player counts as in the room they load in (rndLastLoc: no new checkpoint there)
  if global.location=49 and global.metCheckpoint[0]=rIntro
  {
    var tRm,tRmName,tE;
    tRm=ini_read_real("ALPHA","130rm",-1)
    roomToPlace=rCCity_NorthA
    global.newMapX=608
    global.newMapY=320
    if tRm>rTitle
    {
      if room_exists(tRm) and rndERLoad()=1
      {
        tRmName=room_get_name(tRm)
        for(tE=0;tE<global.rndEEN;tE+=1)
        {
          if global.rndERName[global.rndEERoom[tE]]=tRmName
          {
            roomToPlace=tRm
            global.newMapX=global.rndEEX[tE]
            global.newMapY=global.rndEEY[tE]
            break
          }
        }
      }
    }
    global.metCheckpoint[0]=roomToPlace
    global.metCheckpoint[1]=global.newMapX
    global.metCheckpoint[2]=global.newMapY
  }
  global.rndLastLoc=global.location
  //a save from a build with other data: what's missing reads as not got yet (then brought up to this build: rndLoadOld)
  if string_length(global.rndGot)<global.rndLocN {global.rndGot+=string_repeat("0",global.rndLocN-string_length(global.rndGot))}
  if string_length(global.rndBossDone)<global.rndBossN {global.rndBossDone+=string_repeat("0",global.rndBossN-string_length(global.rndBossDone))}
  rndLoadOld()
  //the Nightmare Gates whose boss's room the player has been in (their first room's way straight to it: the roomStart
  //hook). A save from before they were kept: the gates whose boss's room was come into (eGateProg 7), whose boss there
  //is beaten (8, or the place beaten) or whose fight there has been started
  var g,gb,tR;
  global.rndGateReach=ini_read_string(s,"gatereach","")
  if global.rndGateReach=""
  {
    global.rndGateReach="00000000"
    for(g=1;g<=7;g+=1)
    {
      tR=(string_char_at(global.eGateProg,g)="7" or string_char_at(global.eGateProg,g)="8")
      for(gb=0;gb<global.rndBossN;gb+=1)
      {
        if global.rndBossGate[gb]=g {if string_char_at(global.rndBossDone,gb+1)="1" or string_char_at(global.rndBossSeen,gb+1)="1" {tR=1}}
      }
      if tR {global.rndGateReach=rndSetChar(global.rndGateReach,g,"1")}
    }
  }
  if string_length(global.rndGateReach)<8 {global.rndGateReach+=string_repeat("0",8-string_length(global.rndGateReach))}
  //(the character the player is: the roomStart hook switches back to it from one a room's code switches to)
  global.rndCharSeen=global.activeCharacter
  if string_length(global.rndKeyOwn)<50 {global.rndKeyOwn+=string_repeat("0",50-string_length(global.rndKeyOwn))}
  rndShopFromString()
  global.gameProgress=global.rndWorldProg
  global.rndHLProg=0
  rndHLEnter(roomToPlace) //(a Highlands room is made as before the CHAOS Warship's attack)
  global.rndAbomAPSeen=(global.gateHProg>=200) //(the Abomination's AP: given once, as it's beaten, oRndWatcher)
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
