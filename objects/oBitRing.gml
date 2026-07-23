#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=0.1
image_yscale=0.1

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkProg=0
moveSpd=4
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0 //Grow
  {
    image_xscale+=0.1
    image_yscale+=0.1
    if image_xscale=1 {atkProg=1}
  }
  else if atkProg=1 //Move along room
  {
    if type=-1
    {
      x-=moveSpd
      if x<=oMMBit.xCenter-oMMBit.roomSpan+16 {atkProg=2}
    }
    else if type=1
    {
      x+=moveSpd
      if x>=oMMBit.xCenter+oMMBit.roomSpan-16 {atkProg=2}
    }
  }
  else if atkProg=2 //Move down
  {
    y+=atkProg
    if y>=oMMBit.yGround-16 {atkProg=3}
  }
  else if atkProg=3 //Move along room
  {
    if type=-1
    {
      x+=moveSpd
      if x>=oMMBit.xCenter+oMMBit.roomSpan-16 {instance_destroy()}
    }
    if type=1
    {
      x-=moveSpd
      if x<=oMMBit.xCenter-oMMBit.roomSpan+16 {instance_destroy()}
    }
  }
}
