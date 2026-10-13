//Randomizer: when no placement could be made: each location gets the item of its own number (rndData lists the items
//in the locations' order, so most get their own item back)
var i,k;
global.rndPlace=""
for(i=0;i<global.rndLocN;i+=1)
{
  k=string(i)
  global.rndPlace+=string_repeat("0",3-string_length(k))+k
}
