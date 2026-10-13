//Randomizer: every frame, the abilities the game turned on are the ones the player has found (rndAbilClamp); not in the
//boss gallery's own fights, which give their bosses' abilities
if global.rndActive=1
{
  if !(global.bBossGallery=1 and global.rndFight<0) {rndAbilClamp()}
}
