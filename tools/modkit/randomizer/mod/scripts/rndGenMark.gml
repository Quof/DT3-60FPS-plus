//Randomizer: the locations not reached before that rndGenerate's progression items reach now get layer argument0
//(global.rndGLayer); returns how many
var i,n;
n=0
for(i=0;i<global.rndLocN;i+=1)
{
  if global.rndGLayer[i]<0
  {
    if rndGenReach(i) {global.rndGLayer[i]=argument0; n+=1}
  }
}
return n
