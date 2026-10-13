//Randomizer: every room's start (after its own code)
if global.rndActive=0
{
  //a new game: the intro room. The randomizer takes over from here (rndNewGame goes to the first room)
  if room=rBeginning {rndNewGame()}
  exit
}
if !instance_exists(oRndWatcher) {instance_create(0,0,oRndWatcher)}
//a randomizer boss fight ended: the game went back to the boss gallery (rndBossEnd)
if global.rndFight>=0 and room=rBossGallery {rndBossEnd(); exit}
//the abilities the room's code turned on are the ones the player has found (not in the boss gallery's own fights), and
//swapping characters is on (oRndWatcher keeps the abilities so every frame)
if !(global.bBossGallery=1 and global.rndFight<0)
{
  rndAbilClamp()
  if global.canCharSwap=1 {global.canCharSwap=2}
}
if room=rMain_1 {rndStartRoom()}
