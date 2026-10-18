//Randomizer: with no empty bottle to fill (none, or both filled: rndHintBottle), Up buys a hint instead of a drink:
//where a progression item not found yet is ("Ye who seek Progressive Link, look to Access Gate 4: Megapolis - Newtype
//Airport 1.": rndHintPick, rndHintText), for 1000 Internetz, 1000 more each time, 5000 at most (rndHintCost). The
//locations hinted are kept (rndHinted: not hinted again; the save, the Check Tracker), and nothing's paid when nothing
//is left to hint at. Otherwise as the game's own (its drinks)
if global.rndActive=1 and !rndHintBottle()
{
  //(whether anything's left to hint at, for the Draw event's offer: looked at as the player comes up to the machine and
  //after a hint, not every frame)
  if showMyText<=0 {rndHintLeft=rndHintPick(0)>0}
  showMyText=2
  if global.gamePaused=false and oKeyCodes.kCodePressed[3]=1
  {
    resetKeyCodes()
    var tCost,tLoc;
    tCost=rndHintCost()
    tLoc=rndHintPick(1)
    if oPlayer1.currentMoney=404
    {
      playSound(global.snd_Error,0,1,1)
      msgCreate(120,120,"","There is an error with your current Internetz balance. Please check your balance and try again later.",7,2,oMessagePerson,0)
      newMessage.fadingTime=55
    }
    else if tLoc<0
    {
      playSound(global.snd_Error,0,1,1)
      msgCreate(120,120,"","There's nothing left to seek.",7,2,oMessagePerson,0)
      newMessage.fadingTime=45
    }
    else if oPlayer1.currentMoney<tCost
    {
      playSound(global.snd_Error,0,1,1)
      msgCreate(120,120,"","Not enough Internetz.",7,2,oMessagePerson,0)
      newMessage.fadingTime=35
    }
    else
    {
      playSound(global.snd_MenuConfirm,0,1,1)
      oPlayer1.currentMoney-=tCost
      global.pMoney-=tCost
      global.recInterSpent+=tCost
      global.rndHintN+=1
      global.rndHinted=rndSetChar(global.rndHinted,tLoc+1,"1")
      global.rndTrackDirty=1
      rndHintLeft=rndHintPick(0)>0
      msgCreate(80,120,"",rndHintText(tLoc),7,3,oMessagePerson,0)
      newMessage.fadingTime=210
    }
  }
  exit
}
