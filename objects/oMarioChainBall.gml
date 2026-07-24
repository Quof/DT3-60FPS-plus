#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: dir,swingSpeed,chainLinks
event_inherited()
bActive=true

//Enemy base statistics
atkPower=6
bCanTakeDamage=false
bShowHealthBar=false

initX=x
initY=y

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
initDir=dir
if global.location=88 {atkPower=12}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false && gDeltaDoTicks != 0
{
  dir+=swingSpeed
  x=initX+lengthdir_x(chainLinks*16,dir)
  y=initY+lengthdir_y(chainLinks*16,dir)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
magicInterpDrawStart()
for(i=0;i<chainLinks;i+=1)
{
  draw_sprite_ext(sMarioChainPiece,0,initX+lengthdir_x(i*16,dir),initY+lengthdir_y(i*16,dir),image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
magicInterpDrawEnd()
