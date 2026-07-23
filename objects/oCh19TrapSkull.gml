#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
----- Requires -----
trapType:   type of trap
  **if 1- myDir
  **if 2- trapNum,swingSpeed,chainLinks
trapTime:   timer for trap
trapDelay:  delay for trap
*/
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if trapType=1 {image_blend=make_color_rgb(190,170,120)}
else if trapType=2 //Rotating Spike Trap
{
  var tTrap,tDir;
  tDir=0
  for(i=0;i<trapNum;i+=1)
  {
    tTrap=instance_create(x,y,oCh19RotateTrap)
    tTrap.swingSpeed=swingSpeed
    tTrap.chainLinks=chainLinks
    tTrap.myDir=tDir
    tDir+=360/trapNum
  }
  instance_destroy()
}
else if trapType=3 {image_blend=make_color_rgb(230,140,90)}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  trapTime+=1
  if trapTime=trapDelay
  {
    var tEfCir;
    tEfCir=instance_create(x,y,oEfCircleBlast)
    tEfCir.image_blend=image_blend; tEfCir.image_alpha=0.75; tEfCir.myRad=4; tEfCir.radScl=3; tEfCir.fadeSpeed=0.08
  }
  else if trapTime>=trapDelay+20
  {
    var myAtkTrap,myTrap;
    myAtkTrap=instance_create(x,y,oCh19AtkTraps)
    myAtkTrap.type=0
    if trapType=0 //Big Boulder
    {
      myTrap=instance_create(x,y,oCh19Boulder)
      myTrap.activate=1
      myAtkTrap.damageType="ELEMENTAL"
    }
    else if trapType=1 //Spear
    {
      myTrap=instance_create(x,y,oCh19Spear)
      myTrap.direction=myDir; myTrap.image_angle=myDir
    }
    else if trapType=3 //Big Red Boulder
    {
      myTrap=instance_create(x,y,oCh19RedBoulder)
      myTrap.activate=1
      myAtkTrap.damageType="ELEMENTAL"
    }
    myAtkTrap.myTrap=myTrap
    trapTime=0
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if trapType=1
{
  draw_sprite_ext(sPauseM_Cursor,image_index,x+lengthdir_x(16,myDir),y+lengthdir_y(16,myDir),0.75,0.75,myDir,image_blend,image_alpha)
}
