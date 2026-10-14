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
//a randomizer boss fight ended: the game went back to the boss gallery (rndBossEnd)
if global.rndFight>=0 and room=rBossGallery {rndBossEnd(); exit}
global.rndRoomBoss=-1
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
  //the room of a boss not beaten yet (not the final boss: his door is in Grand Rising): walking up to where its fight
  //starts starts it (oRndWatcher), from the side the player came in on (rndRoomSide); so does leaving the room another
  //way than they came in (the exitPlayer hook)
  var b;
  b=rndBossAt(room)
  if b>=0 and b!=global.rndBossFinal
  {
    if string_char_at(global.rndBossDone,b+1)="0"
    {
      global.rndRoomBoss=b
      global.rndRoomSide=0
      if global.newMapX<global.rndBossFX[b]-16 {global.rndRoomSide=-1}
      else if global.newMapX>global.rndBossFX[b]+16 {global.rndRoomSide=1}
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
if room=rMain_1 {rndStartRoom()}
//Central City - South's heart container, which the 7th trial gives (rndHC7)
rndHC7()
//Nightmare Gate H isn't in the Randomizer: its access gate goes to the mod's own room for it (rRndGateH), which gives
//the gate's instrument and goes on to the Sacred Temple
if room=rHiddenVillage_Destroyed {with (oAccessGate) {if toRoom=rExtGateH_1 {toRoom=rRndGateH; newMapX=64; newMapY=304}}}
