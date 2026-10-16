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
//a Highlands room made as before the CHAOS Warship's attack (rndHLEnter): the endgame's gameProgress back, and Upper
//Crossroad's way to rTS_A, which the attack's rubble shuts (from 4940 its exit is gone; the room logic hasn't it), out
if global.rndHLProg=1
{
  global.gameProgress=global.rndWorldProg
  global.rndHLProg=0
  if room=rMain_84 {with (oExit) {if toRoom=rTS_A {instance_destroy()}}}
}
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
}
//the Access Gates (Chip Randomizer): a gate's rooms come into from outside it without its Program Chip turn the player
//back at once, out the way they came (rndGateBounce), whatever the way in was. rndLastGate: the gate of the room they
//were last in (not counting a boss fight's rooms, the Randomizer's warps); -1 after a load, where they were let in
if global.rndFight<0 and global.bBossGallery=0 and instance_exists(oPlayer1)
{
  var tGate;
  tGate=rndGateOf(room)
  if global.rndChipMode=1 and tGate>0 and global.rndLastGate>=0 and tGate!=global.rndLastGate
  {
    if !rndChipHas(tGate) {rndGateBounce(tGate); exit}
  }
  global.rndLastGate=tGate
  //(turned back from a gate: why, here)
  if global.rndLockMsg>0
  {
    rndMsg(global.rndGateName[global.rndLockMsg]+" is locked.#It opens with Program Chip "+string(global.rndLockMsg)+".",2)
    global.rndLockMsg=0
  }
}
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
    //every boss); once the boss there is beaten, the gate's reward is there (oRndReward)
    if global.rndBossGate[b]>0
    {
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
//each Nightmare Gate's first room, which then give back the area's own few: the mod's version of the script notes the
//room, rndAbilHeldRoom) keeps them so while the player stays in its area: the rooms whose names start as its does, up
//to its last "_" (rndAbilGroup; a Nightmare Gate's other rooms carry its first room's loadout, as in the game). Not
//Gate 6's gate room: Gate 6's own loadout (its Game Powers and the movement abilities only) isn't kept in a Randomizer
//game, whose logic counts every ability found there (its Game Powers only work there, rndAbilApply; the mod's
//pSwapAbility goes round all the sets the player has). Any other room gives back what the player has found, and the
//ability sets they had picked (rndActSave: oRndWatcher): the story gives them back its own way, which a Randomizer
//game's ways between rooms don't follow
if !(global.bBossGallery=1 and global.rndFight<0)
{
  if global.rndFight<0 and global.activeCharacter<2
  {
    var tName,tHeld,k;
    tName=room_get_name(room)
    tHeld=0
    if global.rndAbilHeldRoom=room and !rndInGate6()
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
