//Randomizer: the game's ability variables from what the player has found (global.rndOwn: 0 jump, 1 dash, 2 air dash,
//3 double jump, 4 high jump boots, 5-11 the ability sets' levels found), all on. Walking and swapping characters always are.
//In The Executive's fight, both characters have Gate 6's sets whole and on, as the game's own fight gives them
//(rndExecFight)
var s,l,tExec;
tExec=rndExecFight()
global.hasShoes[0]=2
global.hasShoes[1]=2*(global.rndOwn[0]>0)
global.hasShoes[2]=2*(global.rndOwn[1]>0)
global.hasShoes[3]=2*(global.rndOwn[2]>0)
global.canDoubleJump=2*(global.rndOwn[3]>0)
global.metJumpUpgrade=min(2,global.rndOwn[4])
global.canCharSwap=2
for(s=0;s<7;s+=1)
{
  l=0
  if global.rndOwn[5+s]>0 {l=global.rndOwn[5+s]+1}
  if s>=5 and l>0 and !rndInGate6() {l=1}
  if s>=5 and tExec {l=3}
  global.hasAbilToken[s]=l
}
rndPickSets()
if tExec {global.activeAbility[0]=3; global.activeAbility[1]=3}
if !instance_exists(oRndWatcher) {instance_create(0,0,oRndWatcher)}
