/*
This script is called when the global variables for the player are updated.
*/
stopLoopingSounds()
global.pMaxLife=oPlayer1.maxLife
global.pLife=oPlayer1.life

global.pMoney=oPlayer1.currentMoney

var tNewString;
for(i=0;i<3;i+=1)
{
  tNewString=string_delete(global.extraItems,i+1,1)
  tNewString=string_insert(oPlayer1.pBottles[i],tNewString,i+1)
  global.extraItems=tNewString
}
