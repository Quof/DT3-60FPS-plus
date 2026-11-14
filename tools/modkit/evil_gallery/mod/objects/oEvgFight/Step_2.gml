//Evil Boss Gallery: the boss beaten: its own defeat has written the win (bossRoomTally: the results to show,
//global.bBossResultShow) and is about to go to the Boss Gallery; evgWin makes it the evil gallery's
if global.evgFight>0
{
  if global.bBossResultShow=1
  {
    evgWin()
    instance_destroy()
  }
}
