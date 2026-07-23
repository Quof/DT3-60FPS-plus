#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sMB_Turret
shotTime=0
x+=8; y+=8
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  shotTime+=1
  if shotTime=55 //turn turret
  {
    if type=0 {image_angle=0}
    else if type=1 {image_angle=180}
  }
  else if shotTime=70  {event_user(0)} //fire shot
  else if shotTime=125 //turn turret
  {
    if type=0 {image_angle=315}
    else if type=1 {image_angle=225}
  }
  else if shotTime=140  {event_user(0)} //fire shot
  else if shotTime=195 //turn turret
  {
    image_angle=270
  }
  else if shotTime=210  {event_user(0)} //fire shot
  else if shotTime=265 //turn turret
  {
    if type=0 {image_angle=315}
    else if type=1 {image_angle=225}
  }
  else if shotTime>=280  {event_user(0); shotTime=0} //fire shot
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tNewAttack;
tNewAttack=instance_create(x+lengthdir_x(16,image_angle),y+lengthdir_y(16,image_angle),oNormalBullet)
tNewAttack.sprite_index=sprite_index; tNewAttack.atkPower=6; tNewAttack.bulletSpeed=5; tNewAttack.image_angle=image_angle
tNewAttack.direction=image_angle; tNewAttack.image_blend=c_orange
