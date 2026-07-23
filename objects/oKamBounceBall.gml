#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-3,-3,3,3)
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
hitWall=0
atkProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if projType=0 //Summoned by Kamek
  {
    if atkProg>=0 and atkProg<=999 //Spin around origin
    {
      x=xOrig+lengthdir_x(16,myDir)
      y=yOrig+lengthdir_y(16,myDir)
      myDir+=8

      atkProg+=1
      if atkProg=1 {playSound(global.snd_OrbThrow,0,0.9,38000)}
      if atkProg<=48 {yOrig-=1}
      else if atkProg>=90
      {
        if type=0 {xVel=3; yVel=3}
        else if type=1 {xVel=-3; yVel=3}
        else if type=2 {xVel=3; yVel=-3}
        else if type=3 {xVel=-3; yVel=-3}
        playSound(global.snd_OrbThrow,0,0.98,19000)
        atkProg=1000
      }
    }
    else if atkProg=1000 //Bounce around room
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sKamAtkBFade; tEffect.newBlend=-1; tEffect.fadeSpd=0.1
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.depth=26

      if isCollisionBottom(1)
      {
        playSound(global.snd_RupeeBounce,0,0.92,30000)
        yVel*=-1
        hitWall+=1
      }
      if isCollisionLeft(1)
      {
        playSound(global.snd_RupeeBounce,0,0.92,30000)
        xVel*=-1
        hitWall+=1
      }
      if isCollisionRight(1)
      {
        playSound(global.snd_RupeeBounce,0,0.92,30000)
        xVel*=-1
        hitWall+=1
      }
      if isCollisionTop(1)
      {
        playSound(global.snd_RupeeBounce,0,0.92,30000)
        yVel*=-1
        hitWall+=1
      }

      if hitWall>=3
      {
        var tEffect,tAtk;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        instance_destroy()
      }
      moveTo(xVel,yVel)
    }
  }
  else if projType=1 //Summoned by wand
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sprite_index; tEffect.image_index=image_index; tEffect.depth=26
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.newBlend=-1; tEffect.fadeSpd=0.1
    tEffect.image_speed=0; tEffect.image_alpha=0.6; tEffect.image_angle=image_angle

    speed=bulletSpeed
    image_angle+=10
  }
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if projType=1 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if projType=1
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.25,image_yscale*1.25,image_angle,image_blend,0.5)
}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
