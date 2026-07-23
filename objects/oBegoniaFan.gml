#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.3
spinning=1
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("noSpin") {spinning=0; image_speed=0}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if spinning=1
  {
    if image_speed<0.3 {image_speed+=0.005}
  }
  else
  {
    if image_speed>0 {image_speed-=0.005}
  }

  if image_speed>=0.2
  {
    if image_angle=0
    {
      if collision_rectangle(x,y-(16*image_yscale),x+224,y+(16*image_yscale),oPlayer1,1,1)
      {
        if !collision_line(x+2,y,oPlayer1.x,oPlayer1.y-26,oSolid,1,1)
          oPlayer1.xVel=8
      }
    }
    else if image_angle=90
    {
      if collision_rectangle(x-(16*image_yscale),y,x+(16*image_yscale),y-224,oPlayer1,1,1)
      {
        if !collision_line(x,y-2,oPlayer1.x,oPlayer1.y-26,oSolid,1,1)
        {
          if oPlayer1.state=oPlayer1.RUNNING {oPlayer1.y-=1}
          oPlayer1.yVel=-8
        }
      }
    }
    else if image_angle=180
    {
      if collision_rectangle(x,y-(16*image_yscale),x-224,y+(16*image_yscale),oPlayer1,1,1)
      {
        if !collision_line(x-2,y,oPlayer1.x,oPlayer1.y-26,oSolid,1,1)
          oPlayer1.xVel=-8
      }
    }
    else if image_angle=270
    {
      if collision_rectangle(x-(16*image_yscale),y,x+(16*image_yscale),y+224,oPlayer1,1,1)
      {
        if !collision_line(x,y+2,oPlayer1.x,oPlayer1.y-26,oSolid,1,1)
          oPlayer1.yVel=8
      }
    }
  }

  if point_distance(x,y,oPlayer1.x,oPlayer1.y)<640 and image_speed>=0.2
  {
    if oGame.time mod 6=0
    {
      var tEffect;
      if image_angle=0
      {
        tEffect=instance_create(x+8+random(8*image_xscale),y+random_range(-15*image_yscale,15*image_yscale),oBegoniaFanEffect)
        tEffect.xSpd=4+random(1); tEffect.ySpd=0
      }
      else if image_angle=90
      {
        tEffect=instance_create(x+random_range(-15*image_yscale,15*image_yscale),y-8-random(8*image_xscale),oBegoniaFanEffect)
        tEffect.xSpd=0; tEffect.ySpd=-4-random(1)
      }
      else if image_angle=180
      {
        tEffect=instance_create(x-8-random(8*image_xscale),y+random_range(-15*image_yscale,15*image_yscale),oBegoniaFanEffect)
        tEffect.xSpd=-4-random(1); tEffect.ySpd=0
      }
      else if image_angle=270
      {
        tEffect=instance_create(x+random_range(-15*image_yscale,15*image_yscale),y+8+random(8*image_xscale),oBegoniaFanEffect)
        tEffect.xSpd=0; tEffect.ySpd=4+random(1)
      }
      tEffect.image_angle=image_angle
    }
  }
}
