if global.gamePaused=false
{
  if type=6
  {
    if activated=1
    {
      timeLeft-=1*gDeltaTime
      if timeLeft<=0
      {
        activated=0
        timeLeft=15
      }
    }
  }
  else if type=8 //spsp ns
  {
    if bouncePlayerTime>0
    {
      oPlayer1.yVel=-16
      //bouncePlayerTime-=1
      bouncePlayerTime-=1*gDeltaTime //60fps change: per frame
    }
  }
}

if !instance_exists(ownerID)
    ownerID=GID(ownerCache)

//lag fix (added): an enemy/trap shadow (types 1-3) whose owner is well off screen isn't moved, and is hidden till it's
//moved again (its Step runs before the Draw). Gate C has up to ~150 of these and almost all of them are off screen at
//any time; moving every one every frame lagged (4x the work at 120fps). The margin is more than the furthest a shadow
//can be from its owner (maxShadowDist/1.5), so one that's skipped can't be on screen or touching the player. Switch
//shadows (5, 6) are always moved, as the player's attacks can reach them from anywhere
if instance_exists(ownerID) and type<=3
{
  var tShM;
  tShM=256
  if variable_local_exists("maxShadowDist") {tShM=maxShadowDist+64}
  if ownerID.x<view_xview[0]-tShM or ownerID.x>view_xview[0]+view_wview[0]+tShM or ownerID.y<view_yview[0]-tShM or ownerID.y>view_yview[0]+view_hview[0]+tShM
  {
    visible=0
    exit
  }
  visible=1
}

if instance_exists(ownerID)
{
  /*
  distToMid=point_distance(ownerID.x,0,roomMid,0)
  xOffset=distToMid/(room_width/50)
  if xOffset>40 {xOffset=40}
  if ownerID.x<roomMid {xOffset*=-1}
  x=ownerID.x+xOffset

  nearFlame=instance_nearest(ownerID.x,ownerID.y,oGateCFlame)
  if instance_exists(nearFlame)
  {
    distToFlame=point_distance(ownerID.x,0,nearFlame.x,0)
    if distToFlame<maxShadowDist
    {
      //distToFlame=96-(distToFlame/2)
      distToFlame=(maxShadowDist/1.5)-(distToFlame/1.5)
      if distToFlame<20 {distToFlame=20}
    }
    else {distToFlame=20}
  }
  else {distToFlame=20}
  y=ownerID.y-distToFlame
  */

  nearFlame=instance_nearest(ownerID.x,ownerID.y,oGateCFlame)
  /*if ownerID.sprite_index=sWallMaster //spsp ns
  {
    with oGateCFlame {if spec=other.spec {other.nearFlame=id}}
  }*/
  if instance_exists(nearFlame)
  {
    distToFlame=point_distance(ownerID.x,0,nearFlame.x,0)
    if distToFlame<maxShadowDist
    {
      distToFlame=(maxShadowDist/1.5)-(distToFlame/1.5)
      if distToFlame<12 {distToFlame=12}
    }
    else {distToFlame=12}

    newDir=point_direction(ownerID.x,ownerID.y,nearFlame.x,nearFlame.y)
    x=ownerID.x+lengthdir_x(distToFlame,newDir+180)
    y=ownerID.y+lengthdir_y(distToFlame,newDir+180)
  }

  sprite_index=ownerID.sprite_index
  image_index=ownerID.image_index
  if ownerID.sprite_index=sWallMaster
  {
    image_xscale=ownerID.image_xscale*2
    image_yscale=ownerID.image_yscale*1.9
  }
  else if type=7 //spsp ns
  {
    image_xscale=ownerID.image_xscale
    image_yscale=ownerID.image_yscale
  }
  else {image_xscale=ownerID.image_xscale*1.2}
  image_angle=ownerID.image_angle
}
else {instance_destroy()}
