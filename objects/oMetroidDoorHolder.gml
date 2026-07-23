#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_angle=0
{
  x-=16
  myDoor=instance_create(x+24,y,oMetroidDoorColor)
}
else if image_angle=90
{
  myDoor=instance_create(x,y-24,oMetroidDoorColor)
  myDoor.image_angle=90
}
else if image_angle=180
{
  x+=32
  myDoor=instance_create(x-24,y,oMetroidDoorColor)
  myDoor.image_angle=180
}
else if image_angle=270
{
  myDoor=instance_create(x,y+24,oMetroidDoorColor)
  myDoor.image_angle=270
}
myDoor.type=type; myDoor.myHolder=id
if type=0 {myDoor.sprite_index=sMetroidDoorBlue}
else if type=1 {myDoor.sprite_index=sMetroidDoorRed}
else if type=2 {myDoor.sprite_index=sMetroidDoorGreen}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sMetroidDoorHolder,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
