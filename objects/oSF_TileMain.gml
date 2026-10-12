#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
bPulled=0
bEaten=0
closestRip=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if global.gamePaused=false
if global.gamePaused=false and (global.sfRipCount>0 or bPulled=1) //60fps change: a tile with no rip in the room that isn't being pulled has
//nothing to do (both parts below need one), so it stops at one check instead of three, every frame, for each of rSF_I's tiles
{
  //if instance_exists(oSF_WorldRip)
  if global.sfRipCount>0 //60fps change: the rips count themselves (Create/Destroy); every tile asking instance_exists each frame
  //(116 or more of them in rSF_I, 2x/4x as often at 60/120fps) was a large part of that room's lag
  {
    closestRip=instance_nearest(x,y,oSF_WorldRip)
    if closestRip.pullProg>=1
    {
      if point_distance(x,y,closestRip.x,closestRip.y)<=208*closestRip.image_xscale
      {
        bPulled=1
        if x<closestRip.x {xVel=2}
        else {xVel=-2}

        if y<closestRip.y {yVel=2}
        else {yVel=-2}

        if bEaten=0
        {
          if point_distance(x,y,closestRip.x,closestRip.y)<=80
          {
            playSound(global.snd_BoxBreak,0,0.98,11050)
            bEaten=1
          }
        }
      }
    }
  }

  if bPulled=1
  {
    if xVel>0 {image_angle-=5*gDeltaTime}
    else {image_angle+=5*gDeltaTime}
    if yVel<6 {yVel+=0.1*gDeltaTime}
    if y>=room_height+sprite_height {instance_destroy()}

    if bEaten=1
    {
      image_xscale-=0.1*gDeltaTime
      image_yscale-=0.1*gDeltaTime
      if image_xscale<=0.1 {instance_destroy()}
    }
  }
}
