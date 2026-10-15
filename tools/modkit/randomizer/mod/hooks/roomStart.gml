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
  //and the Abomination, the win's order); before that, walking up to him says so (rndRoomWait)
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
}
//the abilities the room's code turned on are the ones the player has found (not in the boss gallery's own fights), and
//swapping characters is on (oRndWatcher keeps the abilities so every frame); not where the room has put the player in
//another character's place
if !(global.bBossGallery=1 and global.rndFight<0)
{
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
