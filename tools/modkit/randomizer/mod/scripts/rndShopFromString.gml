//Randomizer: the equipment shops' stock from the save file's string (global.rndEShopStr); one that doesn't fit this
//build's shops leaves them as the game has them
var i;
for(i=0;i<global.rndEShopN;i+=1) {global.rndEShopNew[i]=global.rndEShopEquip[i]}
if string_length(global.rndEShopStr)!=global.rndEShopN*2 {exit}
for(i=0;i<global.rndEShopN;i+=1) {global.rndEShopNew[i]=real(string_copy(global.rndEShopStr,i*2+1,2))}
