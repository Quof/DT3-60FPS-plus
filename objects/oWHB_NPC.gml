#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-16,-40,16,-1)
image_speed=0.15
runAcc=5
jumpAcc=-7
wallCling=0
actProg=0
actTime=0
slightWaitAfterTele=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room=rGame6_HeroPlainsA
  {
    if oPlayer1.x>=x-96 {oPlayer1.runAcc=3.75}
    else {oPlayer1.runAcc=7.3}
  }

  if slightWaitAfterTele>0
  {
    slightWaitAfterTele-=1
    if slightWaitAfterTele=1 {xVel=runAcc}
  }

  if type=0 //---------------------------------------- Hero Plains A ----------------------------------------
  {
    if actProg=0
    {
      actTime+=1
      if actTime>=10 {actTime=0; actProg+=1}
    }
    else if actProg=1 {xVel=runAcc; actProg+=1}
    else if actProg=2 {if x>=room_width+48 {instance_destroy()}}
  }

  //Movement Physics
  if yVel<12 {yVel+=0.3}
  if isCollisionBottom(1)
    yVel=0
  if isCollisionLeft(1)
    xVel=0
  if isCollisionRight(1)
    xVel=0
  if isCollisionSolid()
    y-=2

  if yVel>8 {yVel=8}
  if yVel=0 {moveTo(xVel,yVel)}
  else {moveTo(xVel*0.75,yVel)}

  //---------- Animation ----------
  if type<100
  {
    if xVel=0 {sprite_index=sWHB_AnimStand; image_speed=0.15}
    else
    {
      sprite_index=sWHB_Walk
      image_speed=(xVel*4.75)/100
    }

    if yVel<0 {sprite_index=sWHB_Jump}
    else if yVel>0 {sprite_index=sWHB_Jump}
  }
}
#define Collision_oCh19_WM_Pathset
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.type=0 //Stop
{
  xVel=0
}
else if other.type=1 //Jump
{
  y-=2
  jumpAcc=other.jumpAcc
  yVel=jumpAcc
}
else if other.type=10 //Teleport
{
  var tEffect;
  tEffect=instance_create(x,y-20,oEffect)
  tEffect.sprite_index=sEfEnergyRip; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.75
  tEffect.image_xscale=0.75; tEffect.image_yscale=0.75; tEffect.image_speed=0.5
  x=other.myX
  y=other.myY
  xVel=0
  tEffect=instance_create(x,y-20,oEffect)
  tEffect.sprite_index=sEfEnergyRip; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.75
  tEffect.image_xscale=0.75; tEffect.image_yscale=0.75; tEffect.image_speed=0.5
  slightWaitAfterTele=20
}

with other {instance_destroy()}
