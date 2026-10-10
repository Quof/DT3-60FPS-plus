/*
dark omen change (added): whether dipswitch argument0 (index in remasterSwitchList) can't be changed right now. New Dark
Omen can't in the boss gallery or during a boss fight (it decides whether a gallery fight can earn a platinum medal:
bossRoomTally); from the title screen's Options it always can. oPauseMenu greys it out and shows a message instead.
Runs in oPauseMenu (titleMode).
*/
if global.dsVar[argument0]="newDarkOmen" and titleMode=0
{
  if global.bBossGallery=1 or global.currentBoss!="" {return 1}
}
return 0
