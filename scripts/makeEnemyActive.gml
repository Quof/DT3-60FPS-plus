/*
This script is called in the enemy step event to check for distance to the player.
When detectDist is less than detectThreshold, the enemy becomes active and will attack the player.
To free up memory, if the enemy is too far, it will become inactive.
argument0: Check type
-- 0: View
-- 1: Player
*/
var tCheckType;
tCheckType=argument0

if tCheckType=0
{
  findTargetX=point_distance(view_xview[0]+240,0,x,0)
  findTargetY=point_distance(0,view_yview[0]+176,0,y)
}
else
{
  findTargetX=point_distance(oPlayer1.x,0,x,0)
  findTargetY=point_distance(0,oPlayer1.y-26,0,y)
}

if bActive=false //Make active
{
  if findTargetX<detectDistX and findTargetY<detectDistY
    bActive=true
}
else //Make inactive
{
  if global.noInactiveState=0
  {
    if checkScreenArea(x,y,inactiveDist)=0
    {
      if bDestroyOnDeactivate=false {bActive=false}
      else
      {
        if questType>0
          enemyQuest(questType)
        instance_destroy()
      }
    }
  }
  //if findTargetX>inactiveDist
  //  bActive=false
}
