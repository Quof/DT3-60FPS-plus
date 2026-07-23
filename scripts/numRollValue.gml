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
  if tDistVal>100000 {tCurVal+=10000}
  if tDistVal>10000 {tCurVal+=1000}
  if tDistVal>1000 {tCurVal+=100}
  if tDistVal>100 {tCurVal+=10}
  if tDistVal>10 {tCurVal+=1}
  if tDistVal>=1 {tCurVal+=1}
}
else if tRType=1
{
  if tDistVal>=1 {tCurVal+=1}
  else if tDistVal<=-1 {tCurVal-=1}
}
else if tRType=2
{
  if tDistVal>=5
  {
    tCurVal+=5
    if tCurVal>tTarVal {tCurVal=tTarVal}
  }
  else if tDistVal<=-5
  {
    tCurVal-=5
    if tCurVal<tTarVal {tCurVal=tTarVal}
  }
}
else if tRType=3
{
  if tDistVal>=150
  {
    tCurVal+=150
    if tCurVal>tTarVal {tCurVal=tTarVal}
  }
  else if tDistVal<=-150
  {
    tCurVal-=150
    if tCurVal<tTarVal {tCurVal=tTarVal}
  }
}

return tCurVal;
