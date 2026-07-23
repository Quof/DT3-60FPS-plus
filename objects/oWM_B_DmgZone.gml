#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
sprite_index=sInvisibleSolidMask
image_alpha=0
x=32
image_xscale=35
image_yscale=15
bCanDealDamage=0

//Enemy base statistics
atkPower=20
bCanTakeDamage=false
bShowHealthBar=false

timeToHit=30
damageTimeThres=210

warmasterCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  timeToHit+=1
  if timeToHit=damageTimeThres
  {
    if oPlayer1.y<272 {y=48}
    else {y=320}
    timeToHit=1000
  }
  else if timeToHit>=1001 and timeToHit<=1065
  {
    image_alpha+=0.01
  }
  else if timeToHit=1066
  {
    bCanDealDamage=1
    image_alpha=1
  }
  else if timeToHit=1068
  {
    bCanDealDamage=0
    image_alpha=0
    timeToHit=0
  }

  if warmasterCheck=2
  {
    global.newMapX=312; global.newMapY=208; room_goto(rBT_HUB)
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(image_alpha)
draw_set_color(c_red)
draw_rectangle(x,y,x+528,y+240,0)
