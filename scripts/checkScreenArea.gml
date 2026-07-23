/*
This script checks how far from x,y based on dist is from the screen boundaries.
Returns true if within those boundaries
use: checkScreenArea(xx,yy,dist)

argument0: x
argument1: y
argument2: distance from screen boundaries

point_distance(tPosX,tPosY,view_xview[0]+(view_wview[0]/2),view_yview[0]+(view_hview[0]/2))
*/
var tPosX,tPosY,tDist;
tPosX=argument0
tPosY=argument1
tDist=argument2

if point_distance(tPosX,0,view_xview[0]+(view_wview[0]/2),0)<(view_wview[0]/2)+tDist and point_distance(0,tPosY,0,view_yview[0]+(view_hview[0]/2))<(view_hview[0]/2)+tDist
  return 1;
else
  return 0;
