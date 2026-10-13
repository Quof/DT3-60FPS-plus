//(the game's own, with the Randomizer's equipment shops: in a randomizer game, each slot sells the equipment the
//shuffle gave it, rndShopEquip)
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  resetKeyCodes()
  global.recPeopleTalkNum+=1

  var tShopObj;
  tShopObj=instance_create(0,0,shopType)
  tShopObj.shopText=shopText
  if shopType=oShopRegenWindow
  {
    tShopObj.healCost=healCost
  }
  else
  {
    tShopObj.cursorMax=maxInv
    var i; for(i=0;i<5;i+=1)
    {
      tShopObj.inventory[i]=inv[i]
      if global.rndActive=1 and shopType=oShopWindow {tShopObj.inventory[i]=rndShopEquip(room,xstart,ystart,i,inv[i])} //Randomizer (added)
    }
  }
  global.gamePaused=true
}
