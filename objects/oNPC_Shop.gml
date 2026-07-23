#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-7,-24,7,-1)
y+=32
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sprite_index!=sVaultShadow and sprite_index!=sEtecoon and sprite_index!=sCh18ShopSign
  {
    if x<=oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
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
    }
  }
  global.gamePaused=true
}
