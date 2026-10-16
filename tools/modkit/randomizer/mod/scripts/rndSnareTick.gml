//Randomizer: the trap items' time (rndSnareSpring), every frame (oRndWatcher) while the game isn't paused: each one's
//time ends with a message (a Darkness Trap's darkness taken away: rndSnareDark; a Wind Orb Trap's orb fades away on its
//own: oRndSnareOrb). A Teleport Trap waiting (sprung in a boss fight or the boss gallery) takes the player once it can
//(rndSnareCanGo)
var k;
if global.gamePaused=false
{
  for(k=1;k<=5;k+=1)
  {
    if global.rndSnareT[k]>0
    {
      global.rndSnareT[k]-=gDeltaTime
      if global.rndSnareT[k]<=0
      {
        global.rndSnareT[k]=0
        if k=1 {rndSnareDark(0); rndMsg("The darkness lifts.",1)}
        else if k=2 {rndMsg("The CHAOS Rocketeers stop coming.",1)}
        else if k=4 {rndMsg("The Achilles curse wears off.",1)}
        else if k=5 {rndMsg("The wind orb dies down.",1)}
      }
    }
  }
}
if global.rndSnarePend=1 {if rndSnareCanGo() {rndSnareTeleport()}}
