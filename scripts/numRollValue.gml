/*
Increments the value till it reaches the target value.
use: numRollValue(currentValue,targetValue,rollType)

argument0: current value
argument1: target value
argument2: if 0: go as fast as highest digit, 1: increment only 1 per frame (can go down)

returns: new value
*/

var tCurVal,tTarVal,tDistVal,tRType;
tCurVal=argument0
tTarVal=argument1
tRType=argument2

tDistVal=tTarVal-tCurVal
if tRType=0
{
  if tDistVal>100000 {tCurVal+=10000*gDeltaTime}
  if tDistVal>10000 {tCurVal+=1000*gDeltaTime}
  if tDistVal>1000 {tCurVal+=100*gDeltaTime}
  if tDistVal>100 {tCurVal+=10*gDeltaTime}
  if tDistVal>10 {tCurVal+=1*gDeltaTime}
  if tDistVal>=1 {tCurVal+=1*gDeltaTime}
}
else if tRType=1
{
  if tDistVal>=1 {tCurVal+=1*gDeltaTime}
  else if tDistVal<=-1 {tCurVal-=1*gDeltaTime}
}
else if tRType=2
{
  if tDistVal>=5
  {
    tCurVal+=5*gDeltaTime
    if tCurVal>tTarVal {tCurVal=tTarVal}
  }
  else if tDistVal<=-5
  {
    tCurVal-=5*gDeltaTime
    if tCurVal<tTarVal {tCurVal=tTarVal}
  }
}
else if tRType=3
{
  if tDistVal>=150
  {
    tCurVal+=150*gDeltaTime
    if tCurVal>tTarVal {tCurVal=tTarVal}
  }
  else if tDistVal<=-150
  {
    tCurVal-=150*gDeltaTime
    if tCurVal<tTarVal {tCurVal=tTarVal}
  }
}

return tCurVal;
