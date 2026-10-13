//Randomizer: the equipment an equipment shop's slot sells (argument0: the shopkeeper's room, argument1, argument2: where
//it started, xstart and ystart; argument3: the slot; argument4: what the game has it sell). The shop is found by its
//room and starting place (rndData's rndEShopAt*: an instance's id in the game isn't the room editor's)
var j,k,s;
s=-1
for(j=0;j<global.rndEShopAtN;j+=1)
{
  if global.rndEShopAtRoom[j]=argument0 and global.rndEShopAtX[j]=round(argument1) and global.rndEShopAtY[j]=round(argument2)
  {
    s=global.rndEShopAtNpc[j]
    break
  }
}
if s<0 {return argument4}
for(k=0;k<global.rndEShopN;k+=1)
{
  if global.rndEShopNpc[k]=s and global.rndEShopSlot[k]=argument3 {return global.rndEShopNew[k]}
}
return argument4
