#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_blend=c_black
image_alpha=0.6
image_yscale=1.4
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=6
  {
    if activated=1
    {
      timeLeft-=1
      if timeLeft<=0
      {
        activated=0
        timeLeft=15
      }
    }
  }
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
  else {image_xscale=ownerID.image_xscale*1.2}
  image_angle=ownerID.image_angle
}
else {instance_destroy()}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
-Types-
1:  Enemies
2:  Traps
3:  Blackmoor
5:  Normal Switches
6:  Timed Switches
*/
if type=2 or type=3 //Trap or Blackmoor to Player
{
  with oPlayer1
    hitPlayer(other.ownerID)
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
-Types-
1:  Enemies
2:  Traps
3:  Blackmoor
5:  Normal Switches
6:  Timed Switches
*/

if type=5 //Player Weapon to Normal Switch
{
  if room=rExtGateC_1
  {
    if oGateCRoomProg.rmProg=0
    {
      if ownerID=(197475)
      {
        playSound(global.snd_SwitchHit,0,1,1)
        with (197561) {instance_destroy()}
        oGateCRoomProg.rmProg+=1
      }
    }
  }
  else if room=rExtGateC_3
  {
    if oGateCRoomProg.flameSwitch[0]=0
    {
      if ownerID=(199515)
      {
        playSound(global.snd_SwitchHit,0,1,1)
        with (199577) {instance_destroy()}
        oGateCRoomProg.flameSwitch[0]+=1
      }
    }
    if oGateCRoomProg.flameSwitch[1]=0
    {
      if ownerID=(199519)
      {
        playSound(global.snd_SwitchHit,0,1,1)
        with (199579) {instance_destroy()}
        oGateCRoomProg.flameSwitch[1]+=1
      }
    }
    if oGateCRoomProg.flameSwitch[2]=0
    {
      if ownerID=(199527)
      {
        playSound(global.snd_SwitchHit,0,1,1)
        with (199580) {instance_destroy()}
        oGateCRoomProg.flameSwitch[2]+=1
      }
    }
  }
}

if type=6 //Player Weapon to Timed Switch
{
  if activated=0
  {
    playSound(global.snd_SwitchHit,0,0.9,1)
    activated=1
  }
}
