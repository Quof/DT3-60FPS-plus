//(60fps change: the sled is a moving solid, which gameStepEvent moves by xVel/yVel read on 30fps ticks; like oMetalBlock's
//yVel, what changes them every frame changes them by a frame's share of a tick)
event_inherited()
if global.gamePaused=false
{
  if instance_number(oIceSledDamage) = 0
  {
    instance_destroy()
  }
  if active = 1
  {
    if curSpd < maxSpd and curSpd > -maxSpd
    {
        //curSpd+=accel
        curSpd+=accel*gDeltaTime //60fps change
    }
  }
  xDir=curSpd
  if isCollisionBottom(2)=0 and gravEffect=false
  {
      if yDir <= 6
      {
        //yDir+=0.3
        yDir+=0.3*gDeltaTime //60fps change
      }
  }
  if isCollisionBottom(1) and gravEffect=false
  {
    if (active=0)
    {
        active=1
    }
    if yDir>=6
    {
      var tEffect;
      tEffect=instance_create(x,y+(sprite_height/2),oEffect)
      tEffect.sprite_index=sGroundDust; tEffect.image_xscale=1.5; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    yDir=-0.2

    yDir=0
  }

  xVel=xDir
  yVel=yDir


  maxY = 5
  origY = y
  if isCollisionBottom(1) = 1
  {
      yVel=-1
  }


  if place_meeting(x,y,oNightmareEffect) {xVel=xDir/2; yVel=yDir}
  //if isCollisionLeft(1) and xVel<0
    //instance_destroy()
  //if isCollisionRight(1) and xVel>0
    //instance_destroy()
  //moveTo(xVel,yVel)
  //if isCollisionBottom(1)
     // yVel=0
    //if isCollisionSolid()
      //yVel-=2
  //enemySlopeMovement()j
  //event_user(0)

}
else {speed=0}
