#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-4,-4,4,4)
image_blend=c_black
lifeTime=90
atkPower=oShadowForm.atkPower
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
  //if xVel>2
  //  xVel-=0.025
  //else if xVel<-2
  //  xVel+=0.025
  //60fps change: the air drag and ground friction ran every frame unscaled (the bomb stopped ~4x sooner at 120fps).
  //Same method as oLinkBomb (this bomb is a copy of it): work out the 30fps tick's slowdown, then above 30fps apply half
  //before the move and half after. The drag now comes after the wall bounce, which gives the same result (it just flips sign).

  if isCollisionLeft(1)
    xVel*=-1
  if isCollisionRight(1)
    xVel*=-1

  var tXAcc; //60fps change (added) from here to the closing brace of the else below
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
    if !variable_local_exists("bxMid") {bxMid=xVel+1; bxHalf=0; bxAcc=0}
    if xVel==bxMid {xVel+=bxHalf+(tXAcc-bxAcc)*0.5}
    else {xVel+=tXAcc*0.5}
    xVel+=tXAcc*gDeltaTime*0.5
    bxMid=xVel; bxHalf=tXAcc*gDeltaTime*0.5; bxAcc=tXAcc
  }

  if isCollisionBottom(1)
  {
    yVel=0
    //if xVel>0
    //  xVel-=0.4
    //else if xVel<0
    //  xVel+=0.4

    if (xVel<0.5 and xVel>0) or (xVel>-0.5 and xVel<0)
      xVel=0
  }
  if isCollisionTop(1)
    yVel=1
  if isCollisionSolid()
    y-=2

  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  lifeTime-=1*gDeltaTime
  if lifeTime<30 and lifeTime>0 //Flash red
  {
    if oGame.time mod (6/gDeltaTime)=0
    {
      if image_blend=c_black
        image_blend=c_red
      else
        image_blend=c_black
    }
  }
  else if lifeTime=0 //Explode
  {
    if checkScreenArea(x,y,64)=1 {playSound(global.snd_BombExplode,0,0.92,1)}
    newAttack=instance_create(x,y,oDamageExplosion)
    newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion; newAttack.decayTime=-100
    newAttack.image_blend=c_black
    instance_destroy()
  }
}
