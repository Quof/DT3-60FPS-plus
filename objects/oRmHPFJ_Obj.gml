#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=4
image_yscale=2
yVel=1
myProg=0
myCol=255
detectDist=208
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=2
{
  image_xscale=4
  image_yscale=4
  detectDist=132
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if myProg=0 //Wait for player
  {
    if point_distance(x+32,y+(8*image_yscale),oPlayer1.x,oPlayer1.y-26)<=detectDist
    {
      playSound(global.snd_Slam,0,0.9,1)
      var tEffect,tNewSentry;
      for(i=0;i<8;i+=1)
      {
        tEffect=instance_create(x+random(64),y+random(16*image_yscale),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
        tEffect.image_speed=0.33; tEffect.xSpd=random_range(-0.25,0.25); tEffect.ySpd=random_range(-0.25,0.25)
      }
      tNewSentry=instance_create(x+32,y+(8*image_yscale),oFacSentry)
      sprite_index=sNull
      if type=2 {myProg=2}
      else {myProg=1}
    }
  }
  else if myProg=1 //Fall and Rotate
  {
    y+=yVel
    if yVel<7 {yVel+=0.15}
    myCol-=4
    image_blend=make_color_rgb(255,myCol,myCol)
    image_angle-=1
    image_alpha-=0.04
    if image_alpha<=0 {instance_destroy()}
  }
  else if myProg=2 //Explode
  {
    for(i=0;i<2;i+=1)
    {
      for(ii=0;ii<2;ii+=1)
      {
        tEffect=instance_create(x+16+(i*32),y+16+(ii*32),oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //Metal block
  draw_background_general(tileHPF,0,0,64,32,x,y,1,1,image_angle,image_blend,image_blend,image_blend,image_blend,image_alpha)
else if type=1 //Blue rectangle block
{
  draw_background_general(tileHPF,64,160,64,16,x,y,1,1,image_angle,image_blend,image_blend,image_blend,image_blend,image_alpha)
  draw_background_general(tileHPF,64,208,64,16,x,y+16,1,1,image_angle,image_blend,image_blend,image_blend,image_blend,image_alpha)
  draw_background_general(tileHPF,160,112,64,8,x,y+32,1,1,image_angle,image_blend,image_blend,image_blend,image_blend,image_alpha)
  draw_background_general(tileHPF,160,112,64,8,x+32,y+32,1,1,image_angle,image_blend,image_blend,image_blend,image_blend,image_alpha)
}
else if type=2 //Blue square block
{
  draw_background_general(tileHPF,64,160,64,64,x,y,1,1,image_angle,image_blend,image_blend,image_blend,image_blend,image_alpha)
}
