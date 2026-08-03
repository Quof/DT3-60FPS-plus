#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=12

phase=0
bulletProg=0
bulletTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bulletProg=0 //Bullets go out
  {
    _speed=2
    bulletTime+=1*gDeltaTime
    if bulletTime>=35
    {
      _speed=0
      bulletTime=0; bulletProg+=1
    }
  }
  else if bulletProg=1 //Bullets stop
  {
    bulletTime+=1*gDeltaTime
    if bulletTime>=20
    {
      if type=0 {_direction=point_direction(xstart,ystart,oPlayer1.x,returnPlayerYCenter())}
      else {_direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())}
      bulletTime=0; bulletProg+=1
    }
  }
  else if bulletProg=2 //Destroy bullets after set time
  {
    _speed=4
    bulletTime+=1*gDeltaTime
    if bulletTime>=180
    {
      instance_destroy()
    }
  }
}
else {_speed=0}

correctSpeedDirection(self)

#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase+=0.03*gDeltaTime
draw_sprite_wave(sprite_index,image_index,x,y,1,4,1,phase)
