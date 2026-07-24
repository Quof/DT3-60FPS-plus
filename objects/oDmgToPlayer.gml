#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
hspeed=random_range(-2,2)
vspeed=-random_range(4,6)
dispTime=10

drawType=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if round(damageValue)>9 {drawNum=2}
else {drawNum=1}

if round(damageValue)>99999999 {drawNum=9}

drawType=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
  x -= hspeed
  y -= vspeed
  x += hspeed * gDeltaTime
  y += vspeed * gDeltaTime
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  vspeed+=0.38*gDeltaTime

  if drawType=1
  {
    if extraType!=0
    {
      for(i=0;i<drawNum;i+=1)
      {
        draw_sprite_ext(sGUI_HitType,extraType-1,x-((drawNum-1)*4)+(i*9),y+9,1,1,0,drawColor,image_alpha)
      }
    }
  }

  draw_set_halign(fa_center)
  draw_set_alpha(image_alpha)
  draw_set_font(fnt_HUDnum)
  textDropShadow(round(damageValue),x,y,drawColor,c_black,2)

  dispTime-=1*gDeltaTime
  if dispTime<=0
  {
    image_alpha-=0.05*gDeltaTime
    if image_alpha<=0 {instance_destroy()}
  }
}
