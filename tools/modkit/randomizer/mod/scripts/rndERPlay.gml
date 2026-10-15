//Randomizer: the seed played through with the room logic's reach (the doors as global.rndERPart has them, the bosses as
//rndBRFight, the items as global.rndPlace): from nothing, every ability and key at a location reached is taken, over
//and over. 1 when all of them are got (the seed can be finished). The instruments are among them only with Instrument
//Randomization (without it each is at its gate's reward, not placed: rndGenerate)
var i,it,tN,tGotN,tNew,N;
N=global.rndLocN
for(i=0;i<global.rndEEvBase;i+=1) {global.rndGHave[i]=0}
rndERReachStart()
tN=0
for(i=0;i<N;i+=1)
{
  tPlayGot[i]=1
  it=rndPlaced(i)
  if global.rndItemProg[it]>0 and !(global.rndItemKind[it]=26 and global.rndIRMode=0) {tPlayGot[i]=0; tN+=1}
}
tGotN=0
tNew=1
while tNew=1
{
  io_handle()
  tNew=0
  for(i=0;i<N;i+=1)
  {
    if tPlayGot[i]=0 and global.rndRPlace[i]=1
    {
      it=rndPlaced(i)
      tPlayGot[i]=1
      tGotN+=1
      tNew=1
      rndERAdd(global.rndItemProg[it],1)
    }
  }
}
if tGotN=tN {return 1}
return 0
