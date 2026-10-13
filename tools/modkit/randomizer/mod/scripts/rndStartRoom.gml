//Randomizer: the first room (the roomStart hook): the starting items not taken yet, a little to either side of where a
//new game starts (240,2048, on the ground: they drop onto it), and the Warmaster's door once the Abomination is beaten
//(gateHProg 200)
var n,L,t,tx;
for(n=1;n<=3;n+=1)
{
  L=rndLocFind(18,n)
  if L>=0
  {
    if !rndIsGot(L)
    {
      if n=1 {tx=200}
      else if n=2 {tx=280}
      else {tx=320}
      t=instance_create(tx,2020,oRndStartItem)
      t.objectNum=n
    }
  }
}
if global.gateHProg>=200 {instance_create(144,2000,oRndFinalDoor)}
