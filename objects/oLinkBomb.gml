#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-4,-4,4,4)
global.recAtkNum+=1
global.stLink_Bomb[2]+=1

if oPlayer1.image_xscale=1
{
  x+=12
  xVel=6
}
else
{
  x-=12
  xVel=-6
}

if oPlayer1.yVel>0
{
  oPlayer1.yVel=0
  scrSlowFall(2,0.4,0)
}
lifeTime=90
inColTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  yVel=scrGravAcc(yVel,0.2,1)
  if isCollisionLeft(1)
    xVel*=-1
  if isCollisionRight(1)
    xVel*=-1

  //horizontal slowdown: air drag (above 2 speed) plus ground friction, worked out per 30fps tick
  var tXAcc;
  tXAcc=0
  if xVel>2 {tXAcc=-0.025}
  else if xVel<-2 {tXAcc=0.025}
  if isCollisionBottom(1)
  {
    if xVel+tXAcc>0 {tXAcc-=0.4}
    else if xVel+tXAcc<0 {tXAcc+=0.4}
  }
  if gDeltaTime==1 {xVel+=tXAcc}
  else
  {
    //Above 30fps: half before the move and half after (added at the start of the next frame, before that move),
    //like scrGravAcc. The 30fps steps (slow down, then move) sit tXAcc/2 off that smooth slowdown, so the speed is
    //shifted by half of any change in the slowdown (e.g. landing), or by tXAcc/2 when something else set the speed
    //(throw, wall bounce, stop). Without this the bomb slid 1-2px further than at 30fps.
    if !variable_local_exists("bxMid") {bxMid=xVel+1; bxHalf=0; bxAcc=0}
    if xVel==bxMid {xVel+=bxHalf+(tXAcc-bxAcc)*0.5}
    else {xVel+=tXAcc*0.5}
    xVel+=tXAcc*gDeltaTime*0.5
    bxMid=xVel; bxHalf=tXAcc*gDeltaTime*0.5; bxAcc=tXAcc
  }
  if isCollisionBottom(1)
  {
    yVel=0
    if (xVel<0.5 and xVel>0) or (xVel>-0.5 and xVel<0)
      xVel=0
  }
  if isCollisionTop(1)
    yVel=1
  if isCollisionSolid()
  {
    y-=2*gDeltaTime
    inColTime+=1*gDeltaTime
    if inColTime=5
    {
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sSamusSMissileEffect; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }

  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if global.optWeaponTrail=1 and gDeltaDoTicks {instance_create(x,y,oEfWeaponTrail)} //once per 30fps tick

  if gDeltaDoTicks {lifeTime-=1}
  if lifeTime<88 and lifeTime>31
  {
    if room!=rExtGateB_6
    {
      if oPlayer1.kActC and oPlayer1.kActCPressed=1 {lifeTime=31}
    }
  }
  else if lifeTime<30 and lifeTime>0 //flash red
  {
    if oGame.time mod (6/gDeltaTime)=0
    {
      if image_blend=c_white {image_blend=c_red}
      else {image_blend=c_white}
    }
  }
  else if lifeTime=0 //explode
  {
    if isCollisionWaterTop(0)
    {
      if checkScreenArea(x,y,64)=1 {playSound(global.snd_LinkBomb,0,0.92,10000)}
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sSamusSMissileEffect; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else
    {
      if checkScreenArea(x,y,64)=1 {playSound(global.snd_BombExplode,0,0.92,20000)}
      var tExpLight;
      tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=3.5; tExpLight.image_yscale=3.5
      instance_create(x,y,oLinkBExplosion)
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
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if lifeTime<=45
{
  draw_set_alpha(1)
  draw_set_halign(fa_middle)
  draw_set_font(fnt_EnemyName)
  textDropShadow(lifeTime,x,y-24,c_white,c_black,3)
}
