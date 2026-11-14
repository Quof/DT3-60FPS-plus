//Logic Test: the Randomizer's places taken since the last frame (global.rndGot, a 1 for each), named as the room logic
//names them (loc TYPE NUMBER: global.rndLocType, rndLocNum). Nothing when the list itself changed (a new game)
var i,n;
n=string_length(global.rndGot)
if string_length(global.ltGotWas)!=n {exit}
for(i=1;i<=n;i+=1)
{
  if string_char_at(global.rndGot,i)="1"
  {
    if string_char_at(global.ltGotWas,i)!="1" {ltOut("got loc "+string(global.rndLocType[i-1])+" "+string(global.rndLocNum[i-1])+" f"+string(global.ltFrame)+" "+ltPos())}
  }
}
