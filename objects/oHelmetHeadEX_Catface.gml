#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0
image_blend=make_color_rgb(144,136,72)
flashProg=0
alternateFlash=0
flashTime=0

bulletProg=0
bulletTime=0
timeAdj=1
catfaceDist=0
catfaceAngle=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if myType=0
{
  flashTime=15
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //Flash flash in and out
  if flashProg=1
  {
    image_alpha+=0.02
    if image_alpha>=1
    {
      flashProg+=1
    }
  }
  else if flashProg=11
  {
    image_alpha-=0.02
    if flashProg<=0
    {
      flashProg+=1
    }
  }

  //Alternate flash
  if alternateFlash=1
  {
    flashTime+=1
    if flashTime=15 {image_alpha=1}
    else if flashTime>=30
    {
      image_alpha=0
      flashTime=0
    }
  }

  //Bullet
  if bulletProg=1
  {
    bulletTime+=timeAdj
    if bulletTime>=20 and bulletTime<=30 and catfaceDist<=5
    {
      catfaceDist=120
      catfaceAngle=0
    }
    catfaceDist-=timeAdj

    if bulletTime>=141
    {
      var tFire;
      tFire=instance_create(x,y,oPassBullet)
      tFire.direction=point_direction(x,y-35,oPlayer1.x,returnPlayerYCenter()); tFire.sprite_index=sWolfHeadShot
      tFire.atkPower=100; tFire.bulletSpeed=4; tFire.decayTime=-100
      if timeAdj<10 {timeAdj+=1}
      bulletTime=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()
if catfaceDist>0
{
  for(i=0;i<24;i+=1)
  {
    draw_sprite_ext(sHelmetHeadEX_Catface,0,x+lengthdir_x(catfaceDist,catfaceAngle+(i*15)),y+lengthdir_y(catfaceDist,catfaceAngle+(i*15)),1,1,catfaceAngle+(i*15),c_white,1)
  }
}
