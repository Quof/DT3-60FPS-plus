//Randomizer: an ability the game turned on that the player hasn't found goes back off (oRndWatcher, every frame: rooms'
//code and story events turn on the story's abilities, e.g. abilSetRemove(0) the sets' full levels); one the game turned
//off stays off (a room may hold some back). In The Executive's fight Gate 6's sets are had whole (rndExecFight)
var s,l,tExec;
tExec=rndExecFight()
if global.rndOwn[0]=0 {global.hasShoes[1]=0}
if global.rndOwn[1]=0 {global.hasShoes[2]=0}
if global.rndOwn[2]=0 {global.hasShoes[3]=0}
if global.rndOwn[3]=0 {global.canDoubleJump=0}
if global.metJumpUpgrade>global.rndOwn[4] {global.metJumpUpgrade=min(2,global.rndOwn[4])}
for(s=0;s<7;s+=1)
{
  l=0
  if global.rndOwn[5+s]>0 {l=global.rndOwn[5+s]+1}
  if s>=5 and tExec {l=3}
  if global.hasAbilToken[s]>l {global.hasAbilToken[s]=l}
}
rndPickSets()
