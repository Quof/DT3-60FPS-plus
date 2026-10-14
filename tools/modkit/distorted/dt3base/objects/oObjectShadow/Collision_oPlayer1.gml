/*
-Types-
1:  Enemies
2:  Traps
3:  Blackmoor
5:  Normal Switches
6:  Timed Switches
*/
if type=2 or type=3 //Trap or Blackmoor to Player
{
  with oPlayer1
    hitPlayer(other.ownerID)
}
