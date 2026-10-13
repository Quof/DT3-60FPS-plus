//Randomizer: the player going through an exit (this is the exit). Into the room of a boss not beaten yet: its fight
//starts there, the boss gallery's way (rndBossStart)
if global.rndActive=1 and global.bBossGallery=0 and global.rndFight<0
{
  var b;
  b=rndBossAt(toRoom)
  if b>=0 and b!=global.rndBossFinal
  {
    if string_char_at(global.rndBossDone,b+1)="0"
    {
      rndBossStart(b,newMapX,newMapY)
      newMapX=global.rndBossX[b]
      newMapY=global.rndBossY[b]
    }
  }
}
