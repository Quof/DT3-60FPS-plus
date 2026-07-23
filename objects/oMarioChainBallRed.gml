#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: swingSpeed,chainLinks,dir
event_inherited()
bActive=true

//Enemy base statistics
if global.location=99 {atkPower=14}
else {atkPower=8}
bCanTakeDamage=false
bShowHealthBar=false

initX=x
initY=y
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  dir+=swingSpeed
  x=initX+lengthdir_x(chainLinks*16,dir)
  y=initY+lengthdir_y(chainLinks*16,dir)
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
for(i=0;i<chainLinks;i+=1)
{
  draw_sprite(sMarioChainPiece,0,initX+lengthdir_x(i*16,dir),initY+lengthdir_y(i*16,dir))
}
draw_sprite(sprite_index,0,x,y)
