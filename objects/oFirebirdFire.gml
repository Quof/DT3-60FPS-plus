#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-3,-3,3,3)
image_speed=0.5

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
bSlide=0
weight=50
grav=0.2
fizzleTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel=scrGravAcc(yVel,grav,1)
  if bSlide=0
  {
    //if xVel>0
    //  image_angle-=10
    //else if xVel<0
    //  image_angle+=10
    if xVel>0
      image_angle-=10*gDeltaTime //60fps change: scaled (spun 2x/4x as fast at 60/120fps)
    else if xVel<0
      image_angle+=10*gDeltaTime //60fps change: scaled
  }
  else if bSlide=1
  {
    if xVel>0
      xVel-=0.1*gDeltaTime
    else if xVel<0
      xVel+=0.1*gDeltaTime

    if (xVel<0.3 and xVel>0) or (xVel>-0.3 and xVel<0)
      xVel=0

    fizzleTime+=1*gDeltaTime
    if fizzleTime>=50 and fizzleTime<=64
    {
      if frac(fizzleTime)=0 //60fps change (added): flicker once per 30fps tick (it flickered every frame, 2x/4x as fast)
      if image_alpha=0.5
        image_alpha=0.75
      else
        image_alpha=0.5
    }
    else if fizzleTime=65
      instance_destroy()
  }

  if isCollisionTop(1)
    yVel=1
  if isCollisionBottom(1)
  {
    yVel=0
    if bSlide=0
    {
      setCollisionBounds(-3,-4,3,0)
      sprite_index=sFirebirdFire
      image_angle=0
      //y-=2*gDeltaTime
      y-=2 //60fps change: a one-off lift when the fire lands, not a per-frame move
      yVel=-1
      bSlide=1
    }
  }
  if isCollisionLeft(1)
    xVel=1
  if isCollisionRight(1)
    xVel=-1
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if y>room_height+32
    instance_destroy()
}
