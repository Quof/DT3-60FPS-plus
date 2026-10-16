//Randomizer: every room's start (after its own code)
if global.rndActive=0
{
  //a new game: the intro room. The randomizer takes over from here: the new game's options window (oRndOptions), then
  //rndNewGame, which goes to Central City. Its intro scene is stopped. An Archipelago game has its options in the
  //multiworld: it starts straight away
  if room=rBeginning
  {
    if global.rndApNext=1 {rndNewGame()}
    else
    {
      with (oIntro) {instance_destroy()}
      instance_create(0,0,oRndOptions)
    }
  }
  exit
}
if !instance_exists(oRndWatcher) {instance_create(0,0,oRndWatcher)}
//a Highlands room made as before the CHAOS Warship's attack (rndHLEnter): the endgame's gameProgress back. Upper
//Crossroad's way to rTS_A out (from 4940 its exit is gone; the room logic hasn't it), and its way to the Hidden Bot
//Village to the destroyed village, as the endgame has it (made before 4930, it leads to the village as it was)
if global.rndHLProg=1
{
  global.gameProgress=global.rndWorldProg
  global.rndHLProg=0
  if room=rMain_84
  {
    with (oExit) {if toRoom=rTS_A {instance_destroy()}}
    with (oExit) {if toRoom=rHiddenVillage {toRoom=rHiddenVillage_Destroyed}}
  }
}
//a Highlands room made as the endgame has it, its way in not having called rndHLEnter (a Teleporting Stone's, a boss
//fight's way back, an Access Gate's or a map's): made again as before the attack, so every way in gives the same
//Highlands. The area the player came from back first, so the area's name shows as the room's code runs again
//(locationCheck)
else if rndHLRoom(room)
{
  global.location=global.rndLastLoc
  rndHLEnter(room)
  room_restart()
  exit
}
//a room whose code doesn't set the area (global.location: the game keeps the one before, its rooms before being in the
//same area there, as Gate 1's rooms after rMario1_1 are), come into from another area (Entrance Rando, the Randomizer's
//warps): its own (rndRoomLoc*), or what goes by the area is the one before's (Gate 6's enemy spawns, Castlevania's
//chicken hearts). Then what the room's instances set by the area as they were made, before the room's code set it: the
//water's control (oWaterVolume: in Gate 5 and Gate 6 the rooms' own code moves it, elsewhere it moves itself)
var k;
for(k=0;k<global.rndRoomLocN;k+=1)
{
  if global.rndRoomLocR[k]=room and global.location!=global.rndRoomLocA[k] {locationCheck(global.rndRoomLocA[k])}
}
with (oWaterVolume) {bSelfControl=!(global.location=49 or global.location=58)}
//the party split (the story's rooms where Jerry and Claire are apart: the one not played stands where they were left,
//oPlayerIdle) only in a room that has that partner. The story's rooms next to a split room turn it off, but the
//Randomizer's ways between rooms (Entrance Rando, its boss fights and the way back from them) can leave a split room for
//one that doesn't, where swapping characters (pSwapCharacter) would look for a partner that isn't there
if global.partySplit=1 and !instance_exists(oPlayerIdle) {global.partySplit=0}
//a character only some rooms make the player (Jeremy's mech, the Abomination's fights' one: rndCharRoom, the rooms
//whose code switches to it), carried into a room that doesn't: back to Jerry or Claire, whichever was played last
//(rndCharLast), with the player's own abilities (those rooms take the sets away). The story's way out of them goes
//through a room that switches back; the Randomizer's ways between rooms (Entrance Rando, its warps) needn't
//the CHAOS Warmaster's room and the one before it (rWarshipZ_E1, E2): their code makes the player Jeremy's mech once
//the story's past the Warmaster (gameProgress 5310, as the endgame world is), but he's the Randomizer's last fight:
//the player's own character there, with what the rooms' own code gives before him (Warship Z's loadout: jumping, the
//double jump and the Mario Ability Set, as found: rndAbilClamp). His fight (the boss gallery's flag on) gives the
//player's own abilities, as every randomizer fight does (below)
if (room=rWarshipZ_E1 or room=rWarshipZ_E2) and global.activeCharacter=2 and instance_exists(oPlayer1)
{
  charSwitcher(global.rndCharLast)
  if global.bBossGallery=0 {global.canCharSwap=2; global.canDoubleJump=2; global.hasAbilToken[0]=2}
}
//a room whose code switches the player between Jerry and Claire as they come in (Nightmare Gates B, C, D and F's first
//rooms, Cackletta's fight, the Bubble Tower's climb), or to one of them from a character only some rooms make them (the
//ways out of the CHAOS Warship's and the Abomination's): in a Randomizer game, where swapping characters always works,
//the player goes on as who they were (rndCharSeen, oRndWatcher's: the last frame before this room), or from such a
//character as the one they played last (rndCharLast). Not the CHAOS Warship's two-floor rooms (rWarshipA, rWarshipB),
//whose code puts Jerry and Claire each on their own floor by where the player comes in. The jump the room's code gave
//the player stays (in Nightmare Gate F the mod's charSwitcher gives the gate's own jump and ice running, as its rooms'
//code does: rndgen.py's SCRIPT_PATCHES)
if instance_exists(oPlayer1) and global.activeCharacter<2 and room!=rWarshipA and room!=rWarshipB
{
  var tWas,tJ0,tJ1,tJ2,tJ3,tJ4;
  tWas=global.rndCharSeen
  if tWas>=2 {tWas=global.rndCharLast}
  if tWas!=global.activeCharacter
  {
    tJ0=oPlayer1.initialJumpAcc; tJ1=oPlayer1.jumpTimeTotal
    tJ2=oPlayer1.jumpBodge60; tJ3=oPlayer1.jumpGravComp60; tJ4=oPlayer1.doubleJumpBodge60
    charSwitcher(tWas)
    oPlayer1.initialJumpAcc=tJ0; oPlayer1.jumpTimeTotal=tJ1
    oPlayer1.jumpBodge60=tJ2; oPlayer1.jumpGravComp60=tJ3; oPlayer1.doubleJumpBodge60=tJ4
  }
}
if instance_exists(oPlayer1)
{
  if global.activeCharacter>=2
  {
    var c,tKeep;
    tKeep=0
    for(c=0;c<global.rndCharRoomN;c+=1) {if global.rndCharRoom[c]=room and global.rndCharRoomCh[c]=global.activeCharacter {tKeep=1}}
    if tKeep=0 {charSwitcher(global.rndCharLast); rndAbilApply()}
  }
  if global.activeCharacter<2 {global.rndCharLast=global.activeCharacter}
  //the Distortion (Hexor's rooms, rndMechRoom*: rndgen.py's MECH_ROOMS): the story has the player go through it as
  //Jeremy's mech, which a scene before it makes them (the endgame world hasn't it); a Randomizer game makes them it as
  //they come in, with its walking and jumping (its rooms keep it: rndCharRoom; any other room makes them their own
  //character again, above). Not in a Chaos game whose shuffle is from a build before it (rndERFeat), which shuffled the
  //Distortion's own doors, its logic's ways through them Jerry's and Claire's
  if global.activeCharacter<2
  {
    var tMech,mc;
    tMech=0
    for(mc=0;mc<global.rndMechRoomN;mc+=1) {if global.rndMechRoom[mc]=room {tMech=1}}
    if tMech=1 and global.rndERMode=3 {tMech=((global.rndERFeat & 4)>0)}
    if tMech=1 {global.hasShoes[0]=2; global.hasShoes[1]=2; charSwitcher(2)}
  }
}
//(the Access Gates' Program Chips, Chip Randomizer: a portal that takes one the player hasn't found can't be used, the
//mod's oAccessGate)
//Gate 5 (location 49, the rSamus5_ rooms): dying there, and a save made there, go back to its checkpoint
//(global.metCheckpoint: the last one the player used there), which the game sets as the player comes into the gate from
//outside it by its own way in (rSamus5_Gate's code). Entrance Rando and the Randomizer's warps can come into any of its
//rooms: where the player comes into it from outside is its checkpoint. Without it, a new game's checkpoint is room 0,
//the game's intro, which goes to the title screen
if global.location=49 and global.rndLastLoc!=49 and global.metCheckpoint[0]!=room
{
  global.metCheckpoint[0]=room
  global.metCheckpoint[1]=global.newMapX
  global.metCheckpoint[2]=global.newMapY
}
global.rndLastLoc=global.location
//(the trackers' state written again: the room the player's in, and after a new game, a load or a boss fight)
global.rndTrackDirty=1
//the enemy traps of the room not beaten yet: each its own object, which starts it once the player's in its arena
//(traps.py)
global.rndTrapActive=-1
var k;
for(k=0;k<global.rndTrapN;k+=1)
{
  if global.rndTrapRoom[k]=room and string_char_at(global.rndTrapDone,k+1)!="1" {instance_create(0,0,global.rndTrapObj[k])}
}
//the story's ability pickups (location type 19, rndStory*: where the story's own were, gone in the endgame world): each
//one in this room whose item isn't taken yet, as a pickup there (oRndStory). In an Archipelago game, only one its
//multiworld has (rndApLocKnown: a world made before these were locations hasn't them)
if global.bBossGallery=0
{
  var n,L,t,tShow;
  for(n=1;n<=global.rndStoryN;n+=1)
  {
    if global.rndStoryRoom[n]=room
    {
      L=rndLocFind(19,n)
      tShow=0
      if L>=0 {tShow=!rndIsGot(L)}
      if tShow and global.rndAP=1 {tShow=(global.rndApLocKnown[L]=1)}
      if tShow
      {
        t=instance_create(global.rndStoryX[n],global.rndStoryY[n],oRndStory)
        t.objectNum=n
        t.sprite_index=global.rndStorySpr[n]
        t.mask_index=global.rndStorySpr[n]
      }
    }
  }
}
//the Discombobulated (rDisco*): its hallways have no places, and its way on to its boss (rDiscoC's exit to rDiscoD) is
//gone in the endgame world. Its way in from rMain_87 leads straight to the boss's room (Defective's, rDiscoI), and that
//room's way out back to where the Discombobulated's own does (the room logic's overrides.txt has the same). Not in a
//game whose shuffle is from a build before it (rndERFeat), which may go through the hallways
if room=rMain_87 or room=rDiscoI
{
  var tDirect;
  tDirect=1
  if global.rndERMode>0 {tDirect=((global.rndERFeat & 2)>0)}
  if tDirect=1
  {
    if room=rMain_87 {with (oExit) {if toRoom=rDiscoA {toRoom=rDiscoI; newMapX=48; newMapY=256}}}
    if room=rDiscoI {with (oExit) {if toRoom=rDiscoH {toRoom=rMain_87; newMapX=512; newMapY=336}}}
  }
}
//a Nightmare Gate's way from its first room straight to its boss's room (an exit of the first room's, which the game
//keeps once the boss's room has been come into, eGateProg 7, or the gate's instrument is had, 9): only once the player
//has been in that room (rndGateReach, below), as the game means it. In a Randomizer game the instrument can be had
//before the gate's been gone through (Instrument Randomization), and a fight in that room from another place (Boss
//Rando) sets 7 too. The room logic hasn't the exit (it reads the gate as not got to yet)
var tGName,tG,tGTo,gb;
tGName=room_get_name(room)
if string_length(tGName)=11 and string_copy(tGName,1,8)="rExtGate" and string_copy(tGName,10,2)="_1"
{
  tG=ord(string_char_at(tGName,9))-64
  if tG>=1 and tG<=7 and string_char_at(global.rndGateReach,tG)!="1"
  {
    tGTo=-1
    for(gb=0;gb<global.rndBossN;gb+=1) {if global.rndBossGate[gb]=tG {tGTo=global.rndBossRoom[gb]}}
    if tGTo>=0 {with (oExit) {if toRoom=tGTo {instance_destroy()}}}
  }
}
//Gate 4's stages' ways back (rndMMBack*: rndgen.py's MM_BACK_EXITS): the game's stages go one way, and a Randomizer
//game gives each of their rooms but the boss rooms an exit at its edge where the player comes in, to the end of the
//room before, beside its exit (as the forward ones are: walked into, its arrow shown). With that exit it's a door the
//shuffle can join anew (below)
if global.bBossGallery=0
{
  var mb,tb;
  for(mb=0;mb<global.rndMMBackN;mb+=1)
  {
    if global.rndMMBackRoom[mb]=room
    {
      tb=instance_create(global.rndMMBackX[mb],global.rndMMBackY[mb],oExit)
      tb.exitType=1
      tb.bShowArrow=true
      tb.toRoom=global.rndMMBackTo[mb]
      tb.newMapX=global.rndMMBackToX[mb]
      tb.newMapY=global.rndMMBackToY[mb]
    }
  }
}
//Entrance Rando: the room's exits that are its doors' ends lead where the shuffle has them (rndERApplyExit)
if global.rndERMode>0
{
  with (oExit) {rndERApplyExit()}
  with (oAccessGate) {rndERApplyExit()}
  with (oDistortionGate) {rndERApplyExit()}
  with (oMMBossDoor) {rndERApplyExit()}
  with (oMetEleExit) {rndERApplyExit()}
  with (oZeldaMapExit) {rndERApplyExit()}
  with (oGameMapExit) {rndERApplyExit()}
}
//a randomizer boss fight ended: the game went back to the boss gallery (rndBossEnd)
if global.rndFight>=0 and room=rBossGallery {rndBossEnd(); exit}
global.rndRoomBoss=-1
global.rndRoomWait=-1
if global.rndFight>=0
{
  //a randomizer boss fight, started (rndBossStart): the room's code has made the boss. The player's own abilities, all on
  //(not when the room has put them in another character's place for the fight)
  if global.activeCharacter<2 {rndAbilApply()}
}
else if global.bBossGallery=0
{
  //where the player came into this room: a boss fight started from it and lost goes back there (rndBossStart)
  global.rndInRoom=room
  global.rndInX=global.newMapX
  global.rndInY=global.newMapY
  //the room of a boss not beaten yet: walking up to where its fight starts starts it (oRndWatcher), from the side the
  //player came in on (rndRoomSide); so does leaving the room another way than they came in (the exitPlayer hook). The
  //CHAOS Warmaster's, at the end of the Warship: only once the Abomination is beaten (gateHProg 200: the 8 instruments
  //and the Abomination, the win's order); before that, walking up to him says so (rndRoomWait). Either way the boss's
  //preview is there till it's beaten (rndBossPreview)
  var b;
  b=rndBossAt(room)
  if b>=0
  {
    if string_char_at(global.rndBossDone,b+1)="0"
    {
      if b=global.rndBossFinal and global.gateHProg<200 {global.rndRoomWait=b}
      else
      {
        global.rndRoomBoss=b
        global.rndRoomSide=0
        if global.newMapX<global.rndBossFX[b]-16 {global.rndRoomSide=-1}
        else if global.newMapX>global.rndBossFX[b]+16 {global.rndRoomSide=1}
      }
      //(in the middle of its arena, the boss fought there, or with Boss Rando smoke till that fight has been seen)
      rndBossPreview(b)
    }
    //a Nightmare Gate's boss room: the game's own scene that starts its fight doesn't come (the Randomizer's does, as for
    //every boss); once the boss there is beaten, the gate's reward is there (oRndReward). The player has been in it
    //(not in a fight): the gate's way from its first room to it is there from now on (above)
    if global.rndBossGate[b]>0
    {
      global.rndGateReach=rndSetChar(global.rndGateReach,global.rndBossGate[b],"1")
      with (oEvExGates)
      {
        bossCheck="0"
        if variable_local_exists("npcElpizo") {with (npcElpizo) {instance_destroy()}}
      }
      if string_char_at(global.rndBossDone,b+1)="1" {rndRewardAt(global.rndBossGate[b],global.rndBossFX[b],global.rndBossFY[b]-24)}
    }
  }
  //the room a boss's fight is gone into by an exit from (rndBossViaFrom: Ridley's hatch in rSamus5_Lv4_N), that boss's
  //place not beaten yet: a Metroid door the endgame world has sealed in it (the hatch's oMetroidDoorHolder is type 3
  //from gameProgress 3070, which nothing opens) is a blue one (type 0: any attack opens it). The holder makes its door a
  //step after the room starts (its alarm), with this type
  for(b=0;b<global.rndBossN;b+=1)
  {
    if global.rndBossViaFrom[b]=room and string_char_at(global.rndBossDone,b+1)="0" {with (oMetroidDoorHolder) {if type=3 {type=0}}}
  }
}
//the abilities the room's code turned on are the ones the player has found (not in the boss gallery's own fights), and
//swapping characters is on (oRndWatcher keeps the abilities so every frame); not where the room has put the player in
//another character's place.
//A room whose own code took abilities away (the game's abilSetRemove(1): the CHAOS Warship's and Warship Z's rooms,
//which then give back the area's own few: the mod's version of the script notes the room, rndAbilHeldRoom) keeps them
//so while the player stays in its area: the rooms whose names start as its does, up to its last "_" (rndAbilGroup).
//Not Gate 6's gate room or a Nightmare Gate's first room: their own loadouts (Gate 6's Game Powers and movement only, a
//Nightmare Gate's own set and few abilities) aren't kept in a Randomizer game, where everything the player has found
//works there (Gate 6's Game Powers in Gate 6 and Nightmare Gate G, whose own sets they are: rndInGate6, rndAbilApply;
//the mod's pSwapAbility goes round all the sets the player has); the room's code still puts its own set on, if found.
//The logic's needs for each gate (overrides.txt's area lines) stay what they are. Any other room gives back what the
//player has found, and the ability sets they had picked (rndActSave: oRndWatcher): the story gives them back its own
//way, which a Randomizer game's ways between rooms don't follow
if !(global.bBossGallery=1 and global.rndFight<0)
{
  if global.rndFight<0 and global.activeCharacter<2
  {
    var tName,tHeld,k;
    tName=room_get_name(room)
    tHeld=0
    if global.rndAbilHeldRoom=room and !rndInGate6() and string_copy(tName,1,8)!="rExtGate"
    {
      tHeld=1
      global.rndAbilGroup=tName
      for(k=string_length(tName);k>=1;k-=1) {if string_char_at(tName,k)="_" {global.rndAbilGroup=string_copy(tName,1,k); break}}
    }
    else if global.rndAbilGroup!=""
    {
      if string_copy(tName,1,string_length(global.rndAbilGroup))=global.rndAbilGroup {tHeld=1}
    }
    if tHeld=0
    {
      if global.rndAbilGroup!=""
      {
        global.activeAbility[0]=global.rndActSave[0]
        global.activeAbility[1]=global.rndActSave[1]
      }
      global.rndAbilGroup=""
      rndAbilApply()
    }
  }
  rndAbilClamp()
  if global.canCharSwap=1 and global.activeCharacter<2 {global.canCharSwap=2}
}
//Central City - South's heart container, which the 7th trial gives (rndHC7)
rndHC7()
//Nightmare Gate H isn't in the Randomizer: its access gate goes to the mod's own room for it (rRndGateH), which counts
//the gate as beaten, has its reward and goes on to the Sacred Temple. The gate is there once the other seven gates'
//bosses are beaten (the game's own wants their instruments taken, and Gate H's not: with Instrument Randomization they
//can be anywhere)
if room=rHiddenVillage_Destroyed
{
  var t,tHas,i;
  tHas=0
  with (oAccessGate) {if toRoom=rExtGateH_1 {toRoom=rRndGateH; newMapX=64; newMapY=304}; if toRoom=rRndGateH {tHas=1}}
  if tHas=0
  {
    for(i=1;i<=7;i+=1) {if string_char_at(global.eGateProg,i)!="8" and string_char_at(global.eGateProg,i)!="9" {tHas=1}}
    if tHas=0
    {
      t=instance_create(480,976,oAccessGate)
      t.cutsceneCheck=0
      t.toRoom=rRndGateH
      t.newMapX=64
      t.newMapY=304
      t.image_blend=make_color_rgb(255,60,60)
      t.heartRec=100
    }
  }
}
if room=rRndGateH {rndRewardAt(8,240,280)}
//the Sacred Temple: the Randomizer gives each gate's instrument where its boss is beaten (oRndReward), or anywhere
//(Instrument Randomization): the temple's own instrument for a beaten gate, and its scene for it, don't come
if room=rSacredTemple
{
  with (oInstrument) {instance_destroy()}
  with (oEvExGates) {instrStory=-1}
}
//a boss just beaten (rndBossEnd, oRndWatcher's Abomination): its AP and a level's worth, the player back in a room
if global.rndBossAPPending!=-1 and global.rndFight<0 and global.bBossGallery=0 and instance_exists(oPlayer1) {rndBossAPAward()}
//John, in Central City - North where the run starts, left of the archway: talking to him turns debug mode on or off
//(oRndJohn), for a seed that has the player stuck
if room=rCCity_NorthA and global.bBossGallery=0 {instance_create(480,288,oRndJohn)}
//the trap items (Traps) in the room: a Darkness Trap's darkness, a Rocketeer Trap's Rocketeer, a Wind Orb Trap's orb, a
//Teleport Trap's
//message, and the way in kept for one later (rndSnareRoom)
rndSnareRoom()
