#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if rMain_22
{
  timeToRock=70
  rockPlacement=instance_create(400,0,oMisc); rockPlacement.type=0; rockPlacement.sprite_index=sRockHitInd
  rockPlacement=instance_create(592,0,oMisc); rockPlacement.type=0; rockPlacement.sprite_index=sRockHitInd
  rockPlacement=instance_create(816,0,oMisc); rockPlacement.type=0; rockPlacement.sprite_index=sRockHitInd
  rockPlacement=instance_create(1152,0,oMisc); rockPlacement.type=0; rockPlacement.sprite_index=sRockHitInd
  rockPlacement=instance_create(1424,0,oMisc); rockPlacement.type=0; rockPlacement.sprite_index=sRockHitInd
}
else if rMain_23
{
  timeToRock=55
  rockPlacement=instance_create(816,0,oMisc); rockPlacement.type=0; rockPlacement.sprite_index=sRockHitInd
  rockPlacement=instance_create(1648,0,oMisc); rockPlacement.type=0; rockPlacement.sprite_index=sRockHitInd
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  timeToRock+=1
  if room=rMain_22
  {
    if timeToRock mod 75=0
    {
      newRock=instance_create(816,0,oCh7BounceBoulder); newRock.moveSpeed=3
      newRock=instance_create(1648,0,oCh7BounceBoulder); newRock.moveSpeed=4
    }
  }
  else if room=rMain_23
  {
    if timeToRock mod 60=0
    {
      newRock=instance_create(400,0,oCh7BounceBoulder); newRock.moveSpeed=2
      newRock=instance_create(592,0,oCh7BounceBoulder); newRock.moveSpeed=2
      newRock=instance_create(816,0,oCh7BounceBoulder); newRock.moveSpeed=2.6
      newRock=instance_create(1152,0,oCh7BounceBoulder); newRock.moveSpeed=1.9
      newRock=instance_create(1424,0,oCh7BounceBoulder); newRock.moveSpeed=2
    }
  }
}
