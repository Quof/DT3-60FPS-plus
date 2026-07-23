#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: rotSpd,rotMax
event_inherited()
sprite_index=sScaledCollision
maxSize=184 //8*23
image_xscale=maxSize
image_yscale=4

//Enemy base statistics
atkPower=12
bCanTakeDamage=false
bShowHealthBar=false
rotatePhase=0
rotTime=0

colPhase=0
colTime=255
bWaggle=0
myDir=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //Size control
  var tMySize;
  tMySize=1
  for(i=0;i<23;i+=1)
  {
    if !collision_line(x,y,x+lengthdir_x(8*i,image_angle),y+lengthdir_y(8*i,image_angle),oSolid,1,1)
    {
      tMySize+=8
    }
    else
    {
      if oGame.time mod 2=0 and checkScreenArea(x,y,224)=1
      {
        var tEffect;
        tEffect=instance_create(x+lengthdir_x(8*i,image_angle)+random_range(-2,2),y+lengthdir_y(8*i,image_angle)+random_range(-2,2),oEffect)
        tEffect.sprite_index=sSamusCannonHit; tEffect.depth=9
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      break;
    }
  }
  image_xscale=tMySize

  //Color change
  if colPhase=0
  {
    colTime-=5
    if colTime<=135 {colPhase=1}
  }
  else if colPhase=1
  {
    colTime+=5
    if colTime>=255 {colPhase=0}
  }

  //Rotate
  rotTime+=1
  if rotatePhase=0
  {
    image_angle+=rotSpd
    if rotTime>=rotMax
    {
      myDir=image_angle
      rotTime=0; rotatePhase+=1
    }
  }
  else if rotatePhase=1
  {
    if rotTime>=15
    {
      image_angle=myDir
      rotTime=0; rotatePhase+=1
    }
  }
  else if rotatePhase=2
  {
    image_angle-=rotSpd
    if rotTime>=rotMax
    {
      myDir=image_angle
      rotTime=0; rotatePhase+=1
    }
  }
  else if rotatePhase=3
  {
    if rotTime>=15
    {
      image_angle=myDir
      rotTime=0; rotatePhase=0
    }
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*if !collision_line(x,y,oPlayer1.x,returnPlayerYCenter(),oSolid,1,1)
{
  redDmgHit(0)
}*/
redDmgHit(0)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_blend=make_color_rgb(255,255,colTime)
if bWaggle=0
{
  draw_sprite_ext(sChaosLaserBeam,0,x,y,image_xscale,1,image_angle,image_blend,1)
  draw_sprite_ext(sChaosLaserBorder,0,x,y,image_xscale,1,image_angle,c_white,1)
  draw_sprite(sChaosLaserBase,0,x,y)
  draw_sprite_ext(sChaosLaserGun,0,x,y,1,1,image_angle,c_white,1)
}
else
{
  draw_sprite_ext(sChaosLaserBeam,0,x,y,image_xscale,1,myDir,image_blend,1)
  draw_sprite_ext(sChaosLaserBorder,0,x,y,image_xscale,1,myDir,c_white,1)
  draw_sprite(sChaosLaserBase,0,x,y)
  draw_sprite_ext(sChaosLaserGun,0,x,y,1,1,myDir,c_white,1)
}
