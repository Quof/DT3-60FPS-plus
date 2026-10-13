//Randomizer: the equipment shops' stock shuffled between all their slots (the shop pool: equipment stays in the shops),
//kept as global.rndEShopNew and, for the save file, global.rndEShopStr (two digits a slot)
var i,j,k;
for(i=0;i<global.rndEShopN;i+=1) {global.rndEShopNew[i]=global.rndEShopEquip[i]}
for(i=global.rndEShopN-1;i>0;i-=1)
{
  j=irandom(i)
  k=global.rndEShopNew[i]; global.rndEShopNew[i]=global.rndEShopNew[j]; global.rndEShopNew[j]=k
}
global.rndEShopStr=""
for(i=0;i<global.rndEShopN;i+=1)
{
  k=string(global.rndEShopNew[i])
  global.rndEShopStr+=string_repeat("0",2-string_length(k))+k
}
