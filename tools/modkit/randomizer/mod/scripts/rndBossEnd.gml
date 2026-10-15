//Randomizer: a randomizer boss fight ended, the game having gone to the boss gallery (the roomStart hook): beaten
//(bossRoomTally set bBossResultShow for the gallery to show the result: the gallery's oEvBossGallery, made by the room's
//code, has taken it by now) or given up from the game over screen. Beaten, it's marked so and the player goes on from
//where they were (rndBossStart's room and place: where they stood in the boss's room, or past it for one the story went
//into another way); the final boss beaten is the win (rndWin). Given up, the player goes back to where they came into
//the room they went into the fight from: a boss has to be beaten to go on, and walking up to it again starts it again.
//What's marked beaten is the boss whose place it was (rndFightSlot: with Boss Rando, another boss is fought there)
var b,s,w;
b=global.rndFight
s=global.rndFightSlot
if s<0 {s=b}
w=(global.bBossResultShow=1)
if instance_exists(oEvBossGallery) {if oEvBossGallery.bDisplayResults=1 {w=1}}
global.rndFight=-1
global.rndFightSlot=-1
global.bBossGallery=0
global.bossTrack=0
global.currentBoss=""
global.bBossResultShow=0
rndAbilApply()
if w {global.rndBossDone=rndSetChar(global.rndBossDone,s+1,"1")}
if b=global.rndBossFinal and w {rndWin(); exit}
transition_kind=0
if w
{
  if global.rndFightRetX<0 {global.newMapX=global.rndFightLastX; global.newMapY=global.rndFightLastY}
  else {global.newMapX=global.rndFightRetX; global.newMapY=global.rndFightRetY}
  room_goto(global.rndFightRetRoom)
  exit
}
global.newMapX=global.rndFightLoseX
global.newMapY=global.rndFightLoseY
room_goto(global.rndFightLoseRoom)
