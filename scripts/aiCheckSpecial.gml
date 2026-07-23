/*
This script checks if a solid is in front of the object.
use: aiCheckSpecial(type,yMax,yAdjust)

argument0: Check type
argument1: y increments to check (in 24 pixels each)
argument2: y adjust
*/
var tAiType,tAiYMax,tAiYAdjust;
tAiType=argument0
tAiYMax=argument1
tAiYAdjust=argument2

if tAiType=0 //no break
{
  if !collision_point(x+(16*image_xscale),y+tAiYAdjust,oSolid,0,1) //No solid in front
  {
    var tAiLook;
    tAiLook=0
    for(i=0;i<tAiYMax;i+=1)
    {
      if !collision_point(x+(16*image_xscale),y+tAiYAdjust+(i*24),oSolid,0,1) //No solid below, do not break
        tAiLook=1
      else
        tAiLook=0
    }
    return tAiLook;
  }
}
else if tAiType=1
{
  if !collision_point(x+(16*image_xscale),y+tAiYAdjust,oSolid,0,1) //No solid in front
  {
    for(i=0;i<tAiYMax;i+=1)
    {
      if !collision_point(x+(16*image_xscale),y+tAiYAdjust+(i*24),oSolid,0,1) //No solid below
      {
        return 1;
        break;
      }
    }
  }
}
