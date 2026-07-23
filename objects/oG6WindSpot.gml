#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sScaledCollision
image_blend=make_color_rgb(210,255,210)
image_alpha=0.08
dirIndex=0
pushBlockX=0
pushBlockY=0
effectMod=6
bWindWorks=1

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_xscale>=608 {effectMod-=1}
if image_yscale>=608 {effectMod-=1}

if image_xscale>=940 {effectMod-=1}
if image_yscale>=940 {effectMod-=1}

if image_xscale>=1408 {effectMod-=1}
if image_yscale>=1408 {effectMod-=1}

if image_xscale>=1856 {effectMod-=1}
if image_yscale>=1856 {effectMod-=1}

if effectMod<1 {effectMod=1}

if variable_local_exists("windOff") {bWindWorks=0}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bWindWorks=1
  {
    if collision_rectangle(x,y,x+image_xscale,y+image_yscale,oPlayer1,1,1)
    {
      if direction=0
      {
        oPlayer1.extForceX=1.85
      }
      else if direction=90
      {
        oPlayer1.extForceY=-1.25
      }
      else if direction=180
      {
        oPlayer1.extForceX=-1.85
      }
      else if direction=270
      {
        oPlayer1.extForceY=1.25
      }
    }

    if point_distance(x,y,oPlayer1.x,oPlayer1.y)<1200
    {
      if oGame.time mod effectMod=0
      {
        var tEffect;
        if direction=0
        {
          tEffect=instance_create(x+random(image_xscale/1.1),y+random(image_yscale),oG6WindEffect)
          tEffect.xSpd=3+random(1); tEffect.ySpd=0
        }
        else if direction=90
        {
          tEffect=instance_create(x+random(image_xscale),y+image_yscale-random(image_yscale/1.1),oG6WindEffect)
          tEffect.xSpd=0; tEffect.ySpd=-3-random(1)
        }
        else if direction=180
        {
          tEffect=instance_create(x+image_xscale-random(image_xscale/1.1),y+random(image_yscale),oG6WindEffect)
          tEffect.xSpd=-3-random(1); tEffect.ySpd=0
        }
        else if direction=270
        {
          tEffect=instance_create(x+random(image_xscale),y+random(image_yscale/1.1),oG6WindEffect)
          tEffect.xSpd=0; tEffect.ySpd=3+random(1)
        }
        tEffect.image_angle=direction
      }
    }
  }
}
#define Collision_oPushRock
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//If the object is inside wind volume, move object
if bWindWorks=1
{
  if global.gamePaused=false
  {
    pushBlockX=0
    pushBlockY=0
    if direction=0 {pushBlockX=2}
    else if direction=90 {pushBlockY=-5}
    else if direction=180 {pushBlockX=-2}
    else if direction=270 {pushBlockY=1}

    with other
    {
      if other.pushBlockY<1 {yVel=other.pushBlockY}
      moveTo(other.pushBlockX,other.pushBlockY)
    }
  }
}
