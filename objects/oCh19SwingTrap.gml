#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: type,chainLinks,myDir
event_inherited()
bActive=true

//Enemy base statistics
atkPower=12
bCanTakeDamage=false
bShowHealthBar=false

swingSpeed=0
initX=x
initY=y

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var myAtkTrap;
myAtkTrap=instance_create(x,y,oCh19AtkTraps)
myAtkTrap.damageType="NORMAL"
myAtkTrap.sprite_index=sprite_index
myAtkTrap.type=1
myAtkTrap.myTrap=id
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  myDir+=swingSpeed
  if type=0 //Down (225,315)
  {
    if myDir>270
    {
      swingSpeed-=0.05
      if swingSpeed<-4 {swingSpeed=-4}
    }
    else
    {
      swingSpeed+=0.05
      if swingSpeed>4 {swingSpeed=4}
    }
  }
  else if type=1 //Up (45,135)
  {
    if myDir>90
    {
      swingSpeed-=0.05
      if swingSpeed<-4 {swingSpeed=-4}
    }
    else
    {
      swingSpeed+=0.05
      if swingSpeed>4 {swingSpeed=4}
    }
  }
  x=initX+lengthdir_x(chainLinks*16,myDir)
  y=initY+lengthdir_y(chainLinks*16,myDir)
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
  draw_sprite_ext(sCh19SwingChain,0,initX+lengthdir_x(i*16,myDir),initY+lengthdir_y(i*16,myDir),image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
