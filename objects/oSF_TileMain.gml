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
if global.gamePaused=false
{
  if instance_exists(oSF_WorldRip)
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
    if xVel>0 {image_angle-=5}
    else {image_angle+=5}
    if yVel<6 {yVel+=0.1}
    if y>=room_height+sprite_height {instance_destroy()}

    if bEaten=1
    {
      image_xscale-=0.1
      image_yscale-=0.1
      if image_xscale<=0.1 {instance_destroy()}
    }
  }
}
