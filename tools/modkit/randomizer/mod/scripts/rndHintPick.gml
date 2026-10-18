//Randomizer: the locations a vending machine's hint can be about (rndHintOk): argument0 1, one of them at random (-1
//none left); 0, how many. In an Archipelago game, those with the player's own progression items first, then another
//world's
var i,n,k,tPass,tPasses;
tPasses=1
if global.rndAP=1 {tPasses=2}
for(tPass=0;tPass<tPasses;tPass+=1)
{
  n=0
  for(i=0;i<global.rndLocN;i+=1) {if rndHintOk(i,tPass) {n+=1}}
  if n>0
  {
    if argument0=0 {return n}
    k=irandom(n-1)
    for(i=0;i<global.rndLocN;i+=1)
    {
      if rndHintOk(i,tPass)
      {
        if k=0 {return i}
        k-=1
      }
    }
  }
}
if argument0=0 {return 0}
return -1
